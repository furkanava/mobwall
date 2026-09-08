# Grove — worked design

This is an authored walkthrough of [the fictional brief](grove.md), not an independent model benchmark. Prices and brand are demo data. No purchase service or analytics were supplied.

## Findings

| Evidence | Consequence | Change | Verification |
| --- | --- | --- | --- |
| Annual card leads with $3.33/month while $39.99/year is subordinate. | The user may misunderstand today's charge. | Lead with $39.99/year; retain the monthly equivalent as secondary. | Compare rendered hierarchy and selected offer to billing data when integrating. |
| “Premium content / exclusive access / no limits” repeats generic benefits. | The actual library and offline entitlement remain unclear. | Name the full guided-session library and offline favorites. | Check copy against the supplied entitlement list. |
| “Continue” does not describe the purchase. | The next action is ambiguous. | “Subscribe yearly” or “Subscribe monthly,” following selection. | Switch plans and inspect CTA and callback product ID together. |
| No runtime code or analytics were supplied. | Checkout reliability and conversion performance are unknown. | Inject handlers; document integration and experiment requirements. | Verify in the host app's store sandbox later. |

## Recommended screen

Keep the quiet green/cream identity and visible dismissal. Use a single scrollable column rather than a fixed-height hero with clipped footer text. Let enlarged text increase the screen's height. Visuals support the content without pushing billing information into tiny text.

- Brand: **GROVE / PLUS**
- Headline: **Make room for a little calm.**
- Supporting line: **Unlock the full library of guided sessions with Grove Plus.**
- Benefits: **Guided sessions for everyday moments**; **Save your favorites for offline listening**; **Build a routine at your own pace**.
- Yearly card: **Yearly — $39.99 / year**. Secondary: **About $3.33 / month, billed yearly**.
- Monthly card: **Monthly — $5.99 / month**. Secondary: **Billed monthly**.
- Yearly CTA: **Subscribe yearly**.
- Yearly disclosure: **$39.99 charged today, then every year. Auto-renews until canceled. Manage or cancel in your App Store subscription settings.**
- Monthly selection changes CTA and disclosure to monthly billing.
- Supporting actions: **Restore purchases**, **Terms**, **Privacy**, and a clearly labeled close control.

Use dark ink `#1F332B`, green `#305443`, and warm paper `#F7F5EB`; body copy should stay readable. Use a prominent headline, medium-weight plan amounts, 24-point outer padding, and clear selected/unselected cards with a checkmark as well as color. The [sample code](../swiftui/PaywallView.swift) implements the proposed structure using scalable system typography and original SF Symbol decoration.

The [gallery](../../assets/preview.png) is a simplified illustration of these decisions, not pixel-equivalent proof of the SwiftUI rendering.

## Test hypothesis

Clear product benefits and explicit billing may improve offer comprehension and verified subscriptions per eligible onboarding viewer. Treat this bundled redesign as one variant; it cannot isolate the contribution of each visual/copy change.

Assign eligible new users consistently to existing or redesigned offers, with identical prices and entitlements. Define the primary metric as verified new paid subscribers within 14 days divided by unique eligible viewers. Monitor refunds, cancellation, purchase errors, and support confusion. Choose sample size and a stopping rule from real baseline data before launch. With low traffic, start with comprehension sessions. No uplift is claimed.

## Verification limits

The brief supports the copy, prices, and no-trial decision. The callback-based code is provided for integration. The repository's [validation record](../../docs/validation.md) distinguishes automated checks from absent iOS runtime and billing tests. Terms/Privacy URLs and production product data must be supplied by the host app.
