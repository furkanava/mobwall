# Design decisions

## Start with product value

Write a one-sentence internal brief: “At [entry point], [audience] wants [outcome]; this purchase unlocks [verified entitlement].” Use it to choose the headline and supporting proof. Prefer concrete benefits over labels such as “Go premium” or unsupported promises.

Use the app's existing visual language when available. For a new direction choose type, color, spacing, imagery, and tone together. Do not reuse a purple gradient, crown icon, or three generic benefit rows for every category.

## Choose a fitting structure

| Situation | Useful starting structure | Tradeoff |
| --- | --- | --- |
| A single locked feature | Feature preview → outcome → relevant entitlement → offer → action | Direct intent match; less space for the whole product story. |
| New onboarding offer | Screen 1: value + concise free/paid comparison → Screen 2: offer + purchase | A concrete candidate to test against the control; each additional step needs a purpose. |
| Onboarding with understood value | Short outcome headline → concise benefits → plan choice → action | Fast to scan; relies on onboarding having established value. |
| Value needs demonstrating | Representative product preview → explanation → offer | More convincing context; more vertical space. |
| Verified trial, eligible user | Outcome → trial-to-paid timeline → offer → trial CTA | Clarifies what happens next; must adapt for ineligible users. |
| Meaningfully different tiers | Compact comparison → selected tier → billing terms | Useful distinctions; avoid dense desktop pricing tables. |

These are starting points, not fixed templates. Explain the choice in relation to the user's app. Do not add plans or trials solely to match a pattern.

Read [flow-patterns.md](flow-patterns.md) for two-screen sequencing and accessible feature tables, and [research.md](research.md) for evidence. A comparative reference report and an in-app free/paid table serve different audiences; do not substitute one for the other.

## Specify a screen someone can implement

Provide element order, exact UI copy, selected/unselected plan appearance, spacing rhythm, color roles, type hierarchy, illustration intent, and action states. Specify the scroll strategy and how the CTA remains reachable without covering disclosures or legal links. If there is no brand, state the chosen visual assumptions.

Plan cards should clearly distinguish selection from decoration. Do not rely on color alone. Show total charge and period, then optional verified savings or price equivalents. Keep important terms legible rather than treating them as decorative fine print.

Comparison tables should be intentionally styled. Specify the container, row dividers, column dividers when needed, header treatment, selected/recommended column treatment, cell padding, numeric alignment, and mobile reflow. A borderless set of labels and values is usually too easy to misread on a paywall.

Use one visually primary purchase action. Other controls still need to be discoverable. Match the CTA to the action and eligibility, such as “Subscribe annually” or “Start 7-day free trial.” Never infer trial eligibility from a pricing label alone.

## Review the visual result

Check a compact device and a normal device, enlarged text, and at least one long-string locale when localization is in scope. Use platform touch-target conventions (commonly 44 pt on iOS and 48 dp on Android), meaningful accessibility labels, sufficient contrast, and screen-reader selection state. Treat these as design defaults, not blanket certification.

Use real product UI or original visuals when possible. Do not copy a competitor's brand, screenshot, or artwork into deliverables without rights. A gallery example demonstrates a pattern, not proven commercial success.
