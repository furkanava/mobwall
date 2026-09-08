# SwiftUI UI sample

An original, fictional meditation-library paywall for iOS 16+. The sample demonstrates a scrollable layout, total-charge prominence, plan selection, enlarged-text layout, and purchase/restore feedback. It is not a billing SDK or a complete app.

Add [PaywallView.swift](PaywallView.swift) to an iOS SwiftUI project and display `GrovePaywallDemo()` from your root view. No packages, accounts, or keys are required for the sample. The demo explicitly reports that no payment was made when its purchase button is tapped.

For an existing app, use `PaywallView` with real data and callbacks instead:

1. Load your actual store products and eligibility. Supply unique stable product IDs and localized labels; the two example prices are fictional USD values.
2. Construct the CTA and disclosure for the actual selected offer. This demo has **no free trial**.
3. Connect purchase and restore to your existing billing service. Return `.verified` only after entitlement verification. The billing service owns transaction observation independently of the screen; navigating away must not lose a transaction.
4. Supply retry, dismissal, Terms, and Privacy handlers. Route already entitled users in the parent app and handle subscription management there.
5. Exercise sandbox purchases, pending transactions, cancellation, failure, restoration, empty/loading product states, VoiceOver, small devices, and localization before shipping.

The sample uses a fixed light palette for this fictional brand. Adapt its copy, appearance, strings/localization resources, and background operation policy to the host app. It contains no telemetry and no automatic entitlement grant.

The repository's macOS CI job type-checks this file against an iOS simulator SDK. That check does not render the view or prove checkout behavior. See [validation status](../../docs/validation.md) for checks actually performed for this release.

## Optional macOS preview

The [saved hosted preview](../../assets/swiftui-preview.png) was rendered from this source on macOS. Its system typography and controls are not proof of iOS appearance. To reproduce on a Mac with Swift and a macOS SDK, run from the repository root:

```sh
swiftc examples/swiftui/PaywallView.swift scripts/render_swiftui.swift -o /tmp/render-swiftui
/tmp/render-swiftui /tmp/paywall-preview.png
```

The renderer writes only the requested image. For real iOS layout and accessibility checks, use Xcode previews and an iOS simulator/device.
