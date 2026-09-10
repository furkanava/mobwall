# Android / Jetpack Compose sample

A runnable native Android demo of the same fictional Grove offer as the SwiftUI sample. It includes yearly/monthly selection, explicit Google Play renewal copy, accessible plan controls, a scrollable layout, system insets, Back/dismissal to a free-screen placeholder, and loading/error/busy/status inputs.

**No real payments are performed.** Tapping Subscribe displays a demo notice. Restore and legal actions explicitly report that they are placeholders. There is no billing dependency, network permission, analytics, or backend.

## Run

Open this `examples/android` directory as a project in Android Studio. Use JDK 17 or newer, Android SDK 36, Build Tools 36.0.0, and Gradle 9.1.0. The pinned baseline is AGP 9.0.1 with its built-in Kotlin 2.2.10 and matching Compose compiler plugin; do not also apply the legacy Kotlin Android plugin.

The included Gradle wrapper selects Gradle 9.1.0. Set your SDK path using Android Studio or `ANDROID_HOME`, then run:

```sh
./gradlew :app:assembleDebug
```

On Windows use `gradlew.bat`. Run the `app` configuration on an emulator/device with Android 6.0 / API 23 or later. Initial dependency resolution requires internet access. This is a pinned example baseline, not a requirement to upgrade or downgrade your app.

## Use in an existing app

Copy [PaywallScreen.kt](app/src/main/java/dev/mobwall/demo/PaywallScreen.kt) and adapt the strings from [strings.xml](app/src/main/res/values/strings.xml). Supply your app's Material theme and brand content. The [demo activity](app/src/main/java/dev/mobwall/demo/MainActivity.kt) shows the state/callback contract; it is not a production purchase service.

- Replace demo prices with localized product/offer data. Keep the billed total, pricing phase, eligibility-aware CTA, and disclosure consistent.
- Use unique offer identities that map to product, base plan, and offer token in your existing billing service. Never select a checkout offer using the display title alone.
- Hoist busy/loading/status state into the host ViewModel. Set busy immediately on an action and reject duplicate operations in the service as well as disabling controls.
- Handle billing lifecycle updates independently of the composable. Pending/canceled purchases grant no access. Verify entitlement and acknowledge completed transactions in the established billing/backend flow.
- Query existing purchases/entitlements for restore and application resume. Connect legal controls to your real published URLs and route already subscribed users appropriately.
- Localize all resources and real offer data. The supplied English strings and USD prices are fictional; the example has no trial.

See the [native Android skill reference](../../skills/mobwall/references/android.md) and [official Google Play guide](https://developer.android.com/google/play/billing/integrate).

## Verify

Android Studio previews are provided for a standard screen and a compact screen with 1.5× text. Preview declarations are not evidence that those previews were rendered.

Exercise both plans and ensure the CTA/disclosure change together. Verify Back, close, and reopening. Check empty/loading/error states by supplying `PaywallUiState`, and ensure a busy state disables plan selection, retry, purchase, and restore. On a device, check TalkBack selection, live feedback, compact/landscape scrolling, large text, and RTL. Production billing requires separate Play sandbox tests.

See the [validation record](../../docs/validation.md) for actual build/device test status.
