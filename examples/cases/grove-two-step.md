# Grove: two-screen onboarding candidate

Original design specification based on [the fictional Grove brief](grove.md). No real purchases, measured uplift, or new entitlements are claimed. The native SwiftUI/Android samples remain the one-screen control; this document specifies the two-screen candidate now implemented in the Flutter demo.

## Design comparison

Compare the existing sample and the proposed candidate using the same fictional product brief. These are authored design alternatives, not observations of third-party apps.

| Candidate | Purpose | Tradeoff | Evidence |
| --- | --- | --- | --- |
| Existing one-screen offer | Present value and plans in one place. | Less navigation, but benefits and offer compete for attention. | [Grove brief](grove.md) and the supplied SwiftUI/Compose examples; no conversion result. |
| Value/comparison → offer | Explain actual Free/Plus differences before asking for payment. | Adds a step that could lose users or duplicate onboarding. | Original design hypothesis; [onboarding research](../../skills/mobile-paywall/references/research.md) supports testing rather than assuming uplift. |

## Screen 1 — value and comparison

**GROVE / PLUS · Step 1 of 2**

Headline: **Make room for a little calm.**

Supporting copy: **Keep your five free starter sessions, or unlock the full library and offline listening with Plus.**

| What you get | Free | Plus |
| --- | --- | --- |
| Guided sessions | 5 starter sessions | Full library |
| Offline listening | — | ✓ |

✓ = Included; — = Not included. In the implemented UI, expose feature and plan names plus availability to screen readers. Keep session limits as text.

Use two honest rows instead of padding the table with invented benefits. The supplied brief establishes these differences; it does not specify session counts for Plus, AI coaching, guaranteed wellbeing outcomes, or a free trial.

Primary action: **See plans** → screen 2. This button does not initiate a purchase.

Secondary action: **Continue with free sessions** → existing free experience. A visible close control has the same exit meaning. No trial or purchase commitment is implied by progression.

## Screen 2 — offer and purchase

**GROVE / PLUS · Step 2 of 2**, with **Back** → screen 1 and **Close** → free experience.

Headline: **Choose your Plus plan.**

- **Yearly — $39.99 / year**. Secondary: **About $3.33 / month, billed yearly**.
- **Monthly — $5.99 / month**. Secondary: **Billed monthly**.
- CTA follows selection: **Subscribe yearly** / **Subscribe monthly**.
- Disclosure: the selected total charged now, actual renewal period, automatic renewal, and the correct platform's subscription-management wording.
- Supporting controls: **Restore purchases**, **Terms**, **Privacy**.

Keep the existing demo's no-trial offer and initially selected yearly plan for a structure-only comparison. Maintain selection across Back/Next. Loading, unavailable products, pending/canceled/failed purchase, and restore feedback use the same host billing contract as the control.

## Layout and verification

Reuse the green/cream brand. Each step scrolls independently within safe areas; do not cram it into an unscrollable frame. At larger text sizes, turn each table row into a labeled feature card showing Free and Plus values. Announce the new step heading and preserve a clear reading order. Mobile targets stay reachable and prices never truncate.

Before shipping, render both steps on each native platform, test navigation and selection persistence, and exercise the existing purchase states. This specification and [illustration](../../assets/two-step.svg) do not establish native implementation or runtime success.

## Experiment

Control: the existing one-screen Grove sample. Candidate: value/comparison then the same offer. Use first-step exposure as the denominator and stable user assignment. Record progression, verified paid subscriptions, refunds/cancellation, and retention over a predeclared window. The combined design can test the whole candidate; a separate follow-up is needed to isolate the table's effect from the extra page.

## Runnable Flutter candidate

The [Flutter demo](../flutter/README.md) now implements this structure with fictional offers and demo callbacks. SwiftUI and Compose remain the single-screen control. See the validation record for actual test limits.
