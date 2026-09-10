# Flutter two-step paywall demo

Runnable Grove UI for Flutter, with iOS/Android hosts and a web preview. Step 1 explains value and compares Free/Plus; step 2 selects the offer and initiates the injected purchase callback. The existing SwiftUI and Compose samples are the one-screen control.

**No real payments are performed.** USD prices and product IDs are fictional, there is no trial or billing SDK, and purchase/restore/legal actions show explicit demo notices. The demo does not unlock a paid entitlement.

## Run

Use Flutter **3.44.7 / Dart 3.12.2** (the checked baseline), or a compatible later release. From this directory:

```sh
flutter pub get
flutter run
```

Select an Android emulator/device, iOS simulator/device on a configured Mac, or use `flutter run -d chrome` for the visual web demo. iOS requires Xcode and appropriate signing for devices. Native build tools are separate from Flutter. Web preview is not a web checkout.

```sh
dart format --output=none --set-exit-if-changed lib test
flutter analyze
flutter test
flutter build web
```

## Integrate

Copy [paywall_flow.dart](lib/paywall_flow.dart) into your existing app and adapt its Grove-specific content, theme and localization. [main.dart](lib/main.dart) is the mock host, not a purchase service. The skill's [Flutter reference](../../skills/mobwall/references/flutter.md) covers the integration decisions.

- Supply real `PaywallOffer` values with a unique full offer ID, store-localized price and matching disclosure/CTA. Map that ID to the product/base plan/offer expected by the existing billing adapter. Duplicate IDs are invalid input. If the selected offer disappears, purchase is disabled until a valid plan is chosen. Offers loaded after an initially empty list require explicit selection.
- Supply `onPurchase`, `onRestore`, retry, dismissal and real legal handlers. The callbacks return `Future<void>` only to manage UI activity; they do not certify entitlement. Service-level guards remain necessary across routes.
- Hoist `loading`, `error`, `busy` and `status` from your controller. `busy` can remain true for a pending store transaction after a callback returns. Expected cancellation should return normally; report neutral status if needed. Translate failures to safe messages instead of exposing raw store errors.
- Keep purchase stream, verification, completion/acknowledgment and restore reconciliation in the established application service. Closing this widget must not lose a pending transaction. Route verified existing subscribers through the host's existing access flow.
- The sample preserves plan selection across its two steps. Its first-step Back/close calls `onDismiss`; adapt this to your navigator. The demo returns to a free-entry placeholder. iOS gesture behavior and Android predictive Back require device verification.
- Layout uses safe areas and scrolling. Binary features use ✓/— with descriptive screen-reader labels; limits stay as text. At narrow widths or larger text, the table becomes labeled feature cards. Localize the English strings and replace fictional entitlements; don't invent differences between billing periods.

## Verification limits

Widget tests cover navigation, selected-offer callbacks, duplicate actions, removed products, loading/error/retry, failure and disposal, and compact 2× text. See the [validation record](../../docs/validation.md) for actual completed checks. UI tests and web output do not establish native build, screen-reader, payment, store-policy or revenue results.

## Scaffold attribution

Platform host files were generated with Flutter 3.44.7. Flutter-derived scaffold assets retain the [Flutter BSD license](FLUTTER_LICENSE). Original paywall UI and tests use the repository MIT license.
