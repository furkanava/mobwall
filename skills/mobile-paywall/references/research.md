# Research ledger: paywall structure and evidence

Source reviewed **2026-09-08**; ledger revised **2026-09-10**. This project did not run the cited study or reproduce its findings. Use supplied screens, the current app journey and accessible first-party references to inform original designs.

## Interpret the numeric result correctly

[Superwall's May 26 report](https://superwall.com/blog/new-postmulti-page-onboarding-paywalls-convert-37-better-than-single-page-heres-why) defines conversion as trial initiations or direct purchases divided by users viewing the onboarding paywall. Paywalls with zero transactions were excluded; inclusion required at least 50 opens. The observed gap is **3.34 percentage points**, approximately **37% relative**, not a 37-point gain or verified revenue uplift. Multi-page means at least two screens. This is a vendor aggregate with selection effects and potential cohort confounding, not a randomized page-count treatment. Prioritize a two/three-screen onboarding experiment; do not promise the same effect elsewhere.

## Compare the ideas, not just the screenshots

| Candidate | Best reason to test | Main tradeoff | Evidence status |
| --- | --- | --- | --- |
| Value → offer (2 screens) | Onboarding still needs to explain the paid outcome. | Extra step can lose users or repeat existing onboarding. | Vendor aggregate supports testing in onboarding; result is not transferable by default. |
| Free / paid feature table | Users cannot tell what upgrading changes. | Dense tables become hard to scan and read aloud. | Product-design hypothesis; no isolated numerical uplift established here. |
| Trial timeline | Eligible users are uncertain about trial and renewal timing. | A reminder promise needs an implemented delivery path. | Product-design hypothesis, not this project's measured result. |
| Single-screen offer | Intent and value are already established at a feature gate or repeat visit. | May omit needed explanation for new users. | Keep as a real control; verify against the app's audience. |
| Product demo / video | A visible capability explains value better than abstract copy. | Asset cost, motion sensitivity, and slower loading. | Candidate pattern, not a conversion guarantee. |

Operational designs are specified in [flow-patterns.md](flow-patterns.md). For market segmentation and packaging experiments, [Superwall's practitioner guide](https://superwall.com/blog/superwall-best-practices-winning-paywall-strategies-and-experiments-to) also recommends localizing and testing by audience. Its generalized uplift claims are not adopted here as measured results for this skill.

## Evidence discipline

Distinguish a **reference observation**, **practitioner recommendation**, **vendor aggregate**, **user-reported case**, and **controlled experiment**. Record the original metric, population, period, exclusions, and source. Do not promote an app's store ranking, a large screenshot collection, or the presence of purchases in several countries into causal proof that a skill increased conversion.
