# Implement in the existing app

Inspect the paywall's caller, design tokens, product loader, entitlement source, purchase/restore service, localization resources, and analytics conventions. Keep edits scoped to the requested screen and necessary supporting code.

## Integration contract

Render plans from verified product data. Keep product identity attached to selection so the selected label, price, trial terms, and purchase request cannot diverge. Do not identify products by their display titles. Preserve stable IDs and existing billing SDKs.

Represent loading, ready, unavailable, purchasing, pending, and failure states as needed by the platform. Disable repeated purchase/restore actions while one is active. An empty product list needs recovery, not a fabricated fallback price. A pending payment grants no access. Treat user cancellation as a normal return to the offer. Successful access must follow the app's verified entitlement result, including pending server synchronization where applicable.

On restore, distinguish restored entitlement, nothing to restore, and failure. Respect existing lifecycle handling and dispose/cancel screen-owned work appropriately. Route existing subscribers through the app's established access or management flow.

## Framework guidance

| Stack | What to preserve and inspect |
| --- | --- |
| SwiftUI | Existing observable/store state, StoreKit or billing-service wrapper, localized product display prices, Dynamic Type, VoiceOver, safe-area and scroll behavior. |
| Kotlin / Jetpack Compose | Hoisted UI state, lifecycle-aware collection, Google Play offer/base-plan identity, TalkBack semantics, system insets, Back navigation. Read [android.md](android.md). |
| Flutter | Existing state management and purchase stream, disposal, localized product data, semantics, text scaling, safe areas and layout constraints. |
| React Native | Existing billing adapter, navigation and state conventions, platform-specific styles, font scaling, accessibility state, safe area and scrolling. |

Use repository dependencies and installed API versions. Read current official framework/SDK documentation when unfamiliar APIs or changed behavior matter. Do not introduce a new payment library just for a layout change.

## Verification

Run the project's relevant checks and build if available. Preview the screen on compact and standard devices; enlarge text. Exercise selection, dismissal, cancellation, failure/retry, pending, restored and absent entitlement, and eligibility changes when the environment supports them. Verify changing plans updates the CTA and offer together.

Use mocks or a store sandbox for checks; do not initiate real purchases as a test. Report source review, type-checking, rendered previews, and sandbox purchase tests separately. A passing UI build is not evidence of a working checkout.

When writing a standalone sample, label it as UI/demo code; inject purchase, restore, legal, and dismissal handlers. Keep sample prices visibly fictional in its documentation. List the integration responsibilities still needed for production.
