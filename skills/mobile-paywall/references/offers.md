# Offers and subscription clarity

The product catalog and eligibility service are the source of truth. A design brief may specify provisional values, but production copy must use localized store/billing data and the application's verified entitlement rules.

- Lead with the actual billed amount and interval. For annual billing, a per-month equivalent is secondary, never a substitute for the annual charge.
- Show savings only when the compared products, entitlements, periods, and prices support the arithmetic. Keep rounding honest; do not compare against invented original prices.
- Show a trial CTA only for an eligible user and selected product. Explain duration, what is charged afterward, and automatic renewal. Handle unknown eligibility conservatively until it resolves.
- Preserve access to restore/sign-in and appropriate subscription management. Use actual Terms and Privacy destinations. Do not invent cancellation capabilities or make the app's close button sound like subscription cancellation.
- If free access exists, make the route back understandable. Hard gates must reflect the actual product model, not a hidden navigation trick.
- Never invent reviews, user counts, endorsements, time limits, health outcomes, or financial results. Use approved evidence or omit the claim.

## Official guidance

Reference check: 2026-09-08. These are selective design reminders, not a complete store review or legal assessment. Recheck live guidance for the platform, region, purchase method, and request before making a current policy claim.

- [Apple subscription guidance](https://developer.apple.com/app-store/subscriptions/) explains subscription information, restoration, legal links, total billing prominence, and trial presentation.
- [Google Play subscription policy](https://support.google.com/googleplay/android-developer/answer/9900533?hl=en) covers clear subscription terms, introductory offers, cancellation information, and misleading purchase flows.

Do not hardcode region-specific payment or external-link rules into this general skill. If browsing is unavailable, mark those questions for verification and continue the design work that does not depend on them.
