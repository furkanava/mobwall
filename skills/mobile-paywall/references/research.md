# Research ledger: paywall structure and evidence

Checked **2026-09-08**. Sources below informed decision rules; this project did not analyze Mobbin's entire catalog or reproduce the cited experiments. The two user-supplied videos were reviewed through their English auto-generated transcripts. Timestamps are approximate; raw transcripts are not redistributed.

## What was actually studied

| Source | Evidence type | Finding or scope | Limit |
| --- | --- | --- | --- |
| [Mobbin paywall video](https://www.youtube.com/watch?v=9ypqs_2fAl8) | Curated screen/flow review + practitioner interview | Title: 2,995 paywalls; interviewee's experience: 4,700+ designs. | Not 690,000 conversion-tested paywalls; no common randomized experiment across the catalog. |
| [Mobbin MCP video](https://www.youtube.com/watch?v=YbLF42BaoZs) | Product/workflow demonstration | 600,000+ app/web screens, flows and animations available as references. Research and compare before designing. | Catalog size is not an experiment sample or proof of effectiveness. |
| [Mobbin MCP page](https://mobbin.com/mcp) | Product documentation/marketing | The reviewed page says 600,000+ and elsewhere 621,500+ shipped screens. | A changing inventory; the 690,000 claim was not substantiated in the reviewed sources. |
| [Superwall onboarding analysis](https://superwall.com/blog/new-postmulti-page-onboarding-paywalls-convert-37-better-than-single-page-heres-why) | Vendor observational aggregate | Over 40M onboarding opens, February–May 2026; reported conversion 12.41% multi-page vs 9.07% single-page. | Read the metric and exclusions below before citing. |

## Video takeaways with locations

The [paywall video](https://www.youtube.com/watch?v=9ypqs_2fAl8) covers the full journey and multi-page preference at **0:38–2:38**, trial-risk explanation at **3:05–4:08**, packaging at **6:54–7:52**, comparison tables and product video at **7:53–8:24**, and materially different experiments plus retention/LTV at **11:08–12:05**. Tables and multi-page layouts are practitioner recommendations to evaluate, not universal requirements. At **4:33–4:54**, the interviewee explicitly says the CTA chevron has not been isolated in a test.

The [MCP video](https://www.youtube.com/watch?v=YbLF42BaoZs) demonstrates reference research, a comparative report, then a design brief/build (**0:42–2:24**); **2:49–3:18** emphasizes researching before generating. This supports the workflow in [mobbin.md](mobbin.md), not an automatic claim that referenced designs convert better.

## Interpret the numeric result correctly

[Superwall's May 26 report](https://superwall.com/blog/new-postmulti-page-onboarding-paywalls-convert-37-better-than-single-page-heres-why) defines conversion as trial initiations or direct purchases divided by users viewing the onboarding paywall. Paywalls with zero transactions were excluded; inclusion required at least 50 opens. The observed gap is **3.34 percentage points**, approximately **37% relative**, not a 37-point gain or verified revenue uplift. Multi-page means at least two screens. This is a vendor aggregate with selection effects and potential cohort confounding, not a randomized page-count treatment. Prioritize a two/three-screen onboarding experiment; do not promise the same effect elsewhere.

## Compare the ideas, not just the screenshots

| Candidate | Best reason to test | Main tradeoff | Evidence status |
| --- | --- | --- | --- |
| Value → offer (2 screens) | Onboarding still needs to explain the paid outcome. | Extra step can lose users or repeat existing onboarding. | Vendor aggregate supports testing in onboarding; result is not transferable by default. |
| Free / paid feature table | Users cannot tell what upgrading changes. | Dense tables become hard to scan and read aloud. | Practitioner recommendation at 7:53; no isolated numerical uplift supplied. |
| Trial timeline | Eligible users are uncertain about trial and renewal timing. | A reminder promise needs an implemented delivery path. | Source-described design pattern, not this project's measured result. |
| Single-screen offer | Intent and value are already established at a feature gate or repeat visit. | May omit needed explanation for new users. | Keep as a real control; verify against the app's audience. |
| Product demo / video | A visible capability explains value better than abstract copy. | Asset cost, motion sensitivity, and slower loading. | Candidate pattern, not a conversion guarantee. |

Operational designs are specified in [flow-patterns.md](flow-patterns.md). For market segmentation and packaging experiments, [Superwall's practitioner guide](https://superwall.com/blog/superwall-best-practices-winning-paywall-strategies-and-experiments-to) also recommends localizing and testing by audience. Its generalized uplift claims are not adopted here as measured results for this skill.

## Evidence discipline

Distinguish a **reference observation**, **practitioner recommendation**, **vendor aggregate**, **user-reported case**, and **controlled experiment**. Record the original metric, population, period, exclusions, and source. Do not promote an app's store ranking, a large screenshot collection, or the presence of purchases in several countries into causal proof that a skill increased conversion.
