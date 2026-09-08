# Flutter integration

Keep the host's state management (Riverpod, Bloc, Provider or other), router, theme, localization and billing adapter. Do not add or replace a billing package just to restyle the paywall. Use the installed Flutter/Dart and plugin APIs; the repository demo's baseline is not a mandate to upgrade the host.

## Offer and lifecycle contract

- Carry a stable **full offer identity** from the product query through selection and checkout, including Android base-plan/offer context where required. Localized price, period, eligibility and disclosure must describe that same offer. A display title or list index is not an identity.
- If products reload and the selection disappears, disable purchase until a valid offer is selected. Never substitute hardcoded prices on query failure. Trials require eligibility-specific data; do not derive eligibility from a price string.
- Preserve the app's early, application-level purchase-stream subscription. Store transactions may finish after the widget is dismissed. The screen must not own the only entitlement listener, and `mounted` only protects UI updates, not transaction delivery.
- Guard purchase and restore in both UI and service. A pending transaction or completed callback is not verified entitlement. Handle user cancellation neutrally, verify using the established backend/SDK, and finish/acknowledge transactions according to that SDK after the appropriate handling. Do not implement a competing acknowledgment path when the existing SDK owns it.
- Restore means querying/reconciling actual purchases; distinguish nothing found, verification pending, restored and failure. Closing a paywall must not grant access or cancel the only transaction observer.

## Multi-step layout

For the two-step candidate, keep selected offer identity above the step widgets. Back from the offer returns to the value screen; Back/close from the first step follows the host router. Integrate `PopScope` with the existing navigation stack, including platform-specific gesture behavior; don't copy a demo callback that replaces its home widget into every app.

Use safe areas, bounded content width and scrolling rather than fixed phone heights. Reflow the comparison into labeled feature cards at narrow widths or large text; don't disable text scaling. Keep real billed totals prominent. Expose selected/enabled state and contextual comparison labels to semantics, meaningful heading/progress, live status, and usable focus order. Test VoiceOver/TalkBack on devices separately from widget semantics.

Localize brand text, CTA, error/recovery copy and store-specific cancellation instructions through the host's localization resources. The demo's English copy and USD prices are fictional. Respect RTL and dynamic text. No fake legal URLs, trial reminders or free-tier limits.

## Verify

Run format/analyzer and focused widget tests for offer identity after reload, back/close behavior, duplicate actions, loading/empty/error states, safe disposal, and compact/large-text scrolling. Preview actual rendering. Separately exercise store sandbox purchase/cancel/pending/restore and verified entitlements on supported iOS/Android devices. A web build or widget test validates UI only.

Official sources, checked 2026-09-08: [Flutter widget testing](https://docs.flutter.dev/cookbook/testing/widget/introduction), [PopScope](https://api.flutter.dev/flutter/widgets/PopScope-class.html), [Flutter-maintained in_app_purchase documentation](https://pub.dev/packages/in_app_purchase). Read the existing SDK's docs when the app uses another billing service.
