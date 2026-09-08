# Audit an existing paywall

Use evidence before taste. A screenshot establishes visible content and approximate hierarchy; code can establish handlers and accessibility properties; neither establishes conversion performance by itself.

## Inspect

| Area | Decision to make |
| --- | --- |
| Entry point | Does the offer answer the intent that brought the user here? A feature gate can explain the requested feature; onboarding must establish broader value. |
| Flow | What happened before the offer? Would a value/comparison step resolve uncertainty or merely repeat onboarding? Do Back and dismissal behave consistently? |
| Entitlement | Can the user tell what changes after buying and what remains free? |
| Comparison | Would a compact free/paid table clarify actual differences? Are the labels, limits, and mobile reading order accurate? |
| Price | Is the actual billed total visible with its period? Is a monthly equivalent subordinate to an annual charge? |
| Trial | Are duration, eligibility, renewal amount, and post-trial billing clear? Does CTA copy match the actual selected offer? |
| Choice | Are plans distinguishable, selectable, and consistent with the purchase request? Is a recommended plan supported by a reason? |
| Hierarchy | Can the user identify the outcome, compare the offer, and find the next action without competing focal points? |
| Trust | Are claims substantiated? Can returning subscribers restore or sign in? Is dismissal clear where free access exists? |
| Usability | Are text and controls usable on a small device, with larger text, and with long localized strings? |
| Runtime | Can users recover from unavailable products, network errors, pending purchases, and restore failures? |

## Findings format

For each important finding include **evidence → consequence → change → verification**. Use severity rather than invented numerical precision:

- **Blocker:** incorrect offer, wrong product purchased, inaccessible primary action, broken entitlement flow.
- **Important:** unclear billing, hidden dismissal where free access exists, missing recovery, illegible terms.
- **Polish:** spacing, illustration balance, stylistic consistency.

Call a style preference a preference. Call an unmeasured conversion idea a hypothesis. An apparent absent control in a cropped screenshot is “not visible in the supplied crop,” not proof it is missing from the app.

Example: “The annual card leads with $3.33/month while $39.99/year is in small footer text. This may obscure the billed amount. Lead with $39.99/year and make the equivalent secondary. Verify the displayed offer matches the store product; test comprehension before attributing any revenue effect.” These are fictional example prices.

Prioritize a small set of material changes. Do not overwhelm a single screen with every possible issue or silently change pricing and entitlements to fit a preferred layout.
