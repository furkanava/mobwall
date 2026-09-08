---
name: mobile-paywall
description: Design mobile app subscription paywalls or audit and improve an existing paywall from screenshots or source code. Use for paywall layout, subscription offer copy, plan selection, and implementation in mobile apps. Does not bypass paywalls or handle general website pricing pages.
license: MIT
---

# Mobile Paywall

Turn a product brief, screenshot, or existing mobile screen into a clear subscription offer and a usable design. When implementation is requested, carry the design into the existing app. Optimize for informed purchase decisions; treat conversion improvements as hypotheses until measured.

## Choose the work from the request

- **Create:** establish the offer and design a new paywall.
- **Improve:** inspect the actual screen or source, prioritize observed problems, then redesign or implement within the requested scope.
- **Audit only:** return findings and test ideas; do not change app code.
- **Implement:** use the existing framework, design system, billing service, and navigation. Do not replace working purchase infrastructure to restyle a screen.

Do not turn a small copy or layout fix into a full redesign. Use the user's language for discussion and the product's locale for UI copy.

## Establish the minimum context

Inspect supplied artifacts and relevant project files first. Identify the product's useful outcome, audience, paywall entry point, paid entitlement, plans, billing periods, trial eligibility, target platform, and requested deliverable. Inspect surrounding screens for typography, spacing, imagery, and tone before inventing a new visual direction.

Ask only for missing facts that change the offer or block implementation. If prices or trial terms are unknown, continue with a labeled design draft and visible placeholders. Do not invent production offers, product IDs, testimonials, legal URLs, discounts, or performance data. Screenshot-only work cannot establish runtime behavior, accessibility semantics, or actual conversion rates; mark these as unknown.

Use existing screenshot/image tools if available. If an image cannot be inspected, say so and request an accessible artifact or text; never claim to have seen it. Work with available tools without requiring an account, paid service, or a particular MCP provider.

## Make and explain the decision

For an existing paywall, read [audit.md](references/audit.md). Anchor each material finding to an observable element or code path. Separate observed defects, plausible friction, and unknowns. Prioritize offer correctness and purchase blockers before visual polish. Do not produce an invented numerical conversion score.

For a new screen or substantial redesign, read [design.md](references/design.md). Choose a visual direction and offer structure that fit the product and entry point. Produce one coherent recommendation by default; add a materially different variant when the user asks or there is a real hypothesis to compare. Specify actual headline, benefits, plan labels, CTA, disclosure, and layout. A list of generic design tips is not a finished design.

For subscription pricing and disclosures, read [offers.md](references/offers.md). Keep the total billed amount and billing period prominent, distinguish trial eligibility states, and preserve a clear dismissal when free access exists. Never fabricate scarcity or hide material terms. Verify current official platform guidance when making a platform-policy claim; if browsing is unavailable, identify the unverified policy question rather than certifying compliance.

## Carry the result into the requested format

- **Screenshot or brief only:** deliver an annotated design specification, exact proposed copy, and a visual mockup if available tools allow. Label mockups and assumed facts. Do not imply a production integration exists.
- **Existing app + implementation request:** read [implementation.md](references/implementation.md) and, for native Android, [android.md](references/android.md), edit the relevant screen, preserve real product data and purchase handlers, and verify the affected flow with available build/test/preview tools.
- **No app + code request:** infer a framework only when the context supports it; otherwise ask which framework. Separate reusable UI from billing callbacks. Label mock data and integration work. Do not describe a visual sample as a working checkout.

For every changed purchase screen, consider product loading and failure, purchase pending/success/cancellation/failure, restore results, existing entitlement, trial eligibility, small screens, larger text, and localization. Implement relevant states when in scope; report states that cannot be exercised. Purchase cancellation is a normal outcome, not a scary error. Never grant access just because the CTA was tapped.

## Verify and deliver

Inspect the rendered result when a preview or simulator is available. Check price prominence, text wrapping, safe areas, reachable controls, contrast, focus/reading order, and selected-plan consistency with the checkout request. Run relevant existing tests and builds. If only source review is possible, explicitly say that visual/runtime validation remains unverified.

For a substantial improvement, read [experiments.md](references/experiments.md) and propose a falsifiable test linked to the actual change. Do not force an experiment plan into a narrow cosmetic request.

Finish with the artifact or changed files, the important design decisions, assumptions, what was actually verified, and any remaining integration work. Offer a shareable before/after only when useful; use authorized assets, omit sensitive data, and never publish or send it automatically.
