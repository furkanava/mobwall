# Multi-screen offers and feature comparisons

Use alongside [research.md](research.md) for substantial design work. These are this skill's operational defaults, informed by sources and product context, not universal laws of conversion.

## Onboarding: include a two-screen candidate

For a new onboarding offer or broad onboarding redesign, include a candidate with **at least two purposeful screens** unless the user asks for a narrower scope or the existing journey already does that work. Keep a one-screen control or explain how the existing control will be retained. If the user explicitly requires a minimum of two screens, fulfill that structure and label the performance expectation as a hypothesis.

Do not count a store payment sheet, loading spinner, or mandatory Terms page as the extra value screen. Do not mechanically insert a page before a proven, high-intent feature gate or make someone traverse completed onboarding again.

| Step | Purpose | Required decisions |
| --- | --- | --- |
| 1. Value and comparison | Explain what upgrading changes in the user's current context. | Outcome headline; representative product/benefit content; concise free/paid table when it clarifies entitlements; “See plans” action; accessible exit when free use exists. No purchase is initiated here. |
| 2. Offer and purchase | Make the actual commitment understandable. | Real plans, total billed amount/period, eligibility-aware trial/renewal terms, selected-plan CTA, Back, dismissal, restore, and legal destinations. |
| Optional 3. Trial expectations | Explain a genuinely complex eligible trial. | Add only when it resolves a specific question; never pad the flow, delay access, or invent a reminder capability. |

Maintain selected offer and entered answers when moving Back. Dismiss should follow the app's existing free/access model rather than silently acting as Next. Purchase must occur only on the clearly identified purchase step. Product errors and accessibility remain first-class on every step. Move screen-reader focus to each new step's heading and expose progress in text when progress is shown.

## In-app free / paid table

Include a compact table in the candidate when the free/paid boundary or tier differences are otherwise unclear. Start with roughly 3–5 decision-relevant rows; expand only for real user needs. A table is not obligatory when there is one simple entitlement or no meaningful free/paid distinction.

- Compare **entitlements**, not monthly vs annual billing when both unlock the same features.
- Use actual names/limits from the product, with visible row labels and readable column headers. Do not invent “unlimited,” free-tier limitations, or locked features to manufacture value.
- Prefer a visible ✓ for included and — for not included in binary feature rows. Keep numeric limits and meaningful differences as text (for example “2 messages/day” versus “Unlimited”). Provide localized screen-reader labels such as “Offline listening, Premium: Included”; never depend on color or an unlabeled glyph. Keep plan headers clear and explain the symbols when their meaning is ambiguous.
- At narrow widths or larger text, reflow to labeled comparison cards per feature; keep the same information. Do not shrink important text into a desktop-style matrix.
- Keep total price and commitment on the purchase step prominent. A feature table cannot replace renewal/trial disclosure.

## Selecting plans and reassurance

Begin with two relevant billing choices when the catalog supports that simplicity. Keep other real plans discoverable through a clear “All plans” route if appropriate. Never hide a materially different option solely to make an expensive plan look compulsory. Selection defaults and trial durations come from the product strategy and eligibility, not a rule that annual always wins.

Use cancellation reassurance only when the wording accurately describes the offer; “cancel anytime” does not promise a prorated refund or immediate termination. A trial timeline may show a reminder only when its actual channel, timing and required permissions are implemented.

## Measurement

Specify both step-level progression and an end-to-end denominator starting at the first exposed step. A higher purchase rate among users reaching step 2 can hide losses on step 1. Distinguish trial start, direct purchase, trial-to-paid, refunds, retention, and net proceeds. Keep price, acquisition and eligibility consistent in a structure test. Geographic slices require enough data and comparable cohorts; seven country flags are not seven successful experiments.
