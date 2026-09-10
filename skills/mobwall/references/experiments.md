# Test the improvement

Make a hypothesis tied to the actual change: “Leading with the feature the user just requested may increase verified subscriptions per eligible paywall viewer because the benefit matches intent.” A cleaner appearance alone does not establish uplift.

Define before launch:

- **Population:** entry point, platform, locale, eligibility, and new/existing subscriber exclusions.
- **Assignment:** stable user-level assignment; prevent users from repeatedly switching variants. Separate materially different offer eligibility groups.
- **Primary metric:** a business outcome with a numerator, denominator, and observation window. Example: users with a verified new paid subscription within 14 days / unique eligible users exposed. A trial that has not matured is not a paid subscription.
- **Diagnostics:** offer load failures, selection, purchase initiation, pending/cancellation/failure, verified entitlement, trial start, and trial-to-paid completion. CTA taps do not equal purchases.
- **Guardrails:** refunds, cancellations, retention, support complaints, accessibility regressions, and net revenue when available.
- **Decision rule:** choose sample size from baseline, minimum useful effect, and chosen statistical method. Set duration and stopping criteria in advance; do not declare a winner from a few early conversions or repeatedly peek without an appropriate sequential method.

Use existing analytics events if present. When adding instrumentation is requested, keep exposure deduplicated and success linked to verified entitlement. Do not log receipts, payment details, screenshots, or personal data for this purpose. A suggested event plan is not permission to add telemetry.

If traffic is too low for a meaningful controlled test, begin with comprehension/usability sessions and report qualitative observations. If only aggregate before/after data exists, discuss cohort, pricing, seasonality, and acquisition changes; do not claim the redesign caused the difference.

For a multi-screen experiment, count exposure from the first step; report step drop-off alongside final conversion. Do not switch the denominator to only users who reached pricing. Country comparisons should separate storefront, UI language, currency, platform, acquisition, and offer eligibility; a country flag does not establish a locale or a winning experiment. See [flow-patterns.md](flow-patterns.md).
