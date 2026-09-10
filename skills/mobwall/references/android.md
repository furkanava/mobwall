# Native Android paywalls

Read for Kotlin/Jetpack Compose or an existing native Android purchase screen. Keep the host architecture, navigation, theme, and billing layer. Do not rewrite a Views-based screen in Compose unless that migration is part of the request.

## Compose screen contract

Hoist product loading, selection, operation state, and feedback into the host state holder. Collect lifecycle-aware state using the project's established approach. Give the UI callbacks for selection, purchase, refresh/restore, retry, dismissal, and legal destinations. Screen recomposition must not launch purchases or repeat analytics events. Remembered screen state is not durable entitlement storage.

Use a scrollable layout with system-bar/cutout insets, scalable text, and minimum 48 dp targets. Give plan selection radio-button semantics; expose each card as one control rather than duplicate nested click targets. Make loading, retry, and pending feedback readable to TalkBack. Test compact portrait, landscape, larger font/display scales, and right-to-left layouts when supported. Preserve system Back behavior and the route to free functionality.

## Google Play integration boundary

Resolve the actual product, base plan, offer token, pricing phases, and eligibility from the billing layer. The UI's stable offer identity must map to the same offer passed to checkout, including when several offers share a product ID. A trial shown for one eligible offer must not leak into another plan's CTA or disclosure.

The host should reconnect/query purchases and process lifecycle updates outside the composable. Distinguish user cancellation, pending payment, purchase failure, and verified access. Do not unlock on `PENDING`. Verify completed purchases, update entitlement, and acknowledge eligible completed transactions using the existing billing/backend flow. Restoring should recheck available purchases/entitlements; it must not grant access from stale UI state. Route existing subscribers through the product's established access or management flow.

Check [Google's billing integration guide](https://developer.android.com/google/play/billing/integrate) and [Compose setup guidance](https://developer.android.com/develop/ui/compose/setup-compose-dependencies-and-compiler) for the installed SDK/API versions when implementing unfamiliar behavior. References checked 2026-09-08. Do not copy versions from an example into a working app just to restyle its paywall.

## Verification

Build the affected module, inspect previews/device output, and exercise plan identity, Back/dismissal, cancellation, pending/failure recovery, and restore results. Use Play license testers or the existing billing sandbox when checkout testing is authorized. A sideloaded UI demo does not verify Play Billing. Report compilation, rendered previews, accessibility checks, and purchase tests separately.
