# Validation record

Release candidate: **0.3.1**, checked **2026-09-10**. This record states what was exercised locally. CI configuration and behavioral rubrics are not completed runs.

| Check | Result | Evidence and limits |
| --- | --- | --- |
| Skill structure | Passed | Bundled skill-creator validator accepted the frontmatter and folder. |
| Repository integrity | Passed | `python3 scripts/check.py`: portable frontmatter subset, local Markdown file links, sixteen evaluation cases and their fixture paths. External URLs are not tested by this script. |
| Installer behavior | Passed | 15 `unittest` tests on macOS: all agent destinations, shared-path deduplication, exact copies, idempotence, dry run, conflicts, links, failed copy cleanup, invalid input, and paths with spaces. |
| SwiftUI source | Passed on macOS SDK | `swiftc -typecheck` accepted the sample. This does not establish compilation against iOS SDKs. |
| SwiftUI preview | Rendered and visually inspected on macOS | Hosted source preview at 390 × 900 points, saved as `assets/swiftui-preview.png`. Plan cards, billed totals, copy and footer inspected. Not an iOS device capture or interaction test. |
| Gallery artwork | Rendered and visually inspected | Original `assets/preview.svg` rasterized to PNG; typography and bounds reviewed. Illustration differs from native system rendering. |
| Android Compose debug APK | Passed | `:app:assembleDebug` completed locally with Gradle 9.1.0, AGP 9.0.1, Kotlin/Compose compiler 2.2.10, SDK 36. Android SDK/Gradle caches and debug signing state were isolated where needed for workspace permissions. |
| Android device/preview/TalkBack | Not run | Standard/large-text preview definitions are included, but no Android preview rendering, emulator interaction, or accessibility service test was performed. |
| iOS simulator/build | Not run locally | Installed Command Line Tools do not include the iOS simulator SDK. A macOS GitHub Actions job is configured for iOS type-checking; it has not run before publication. |
| Store purchase/restore flow | Not run | Sample intentionally uses demo handlers and no store connection. Real products, legal destinations and entitlement verification belong to the host app. |
| Behavioral model evaluations | Not run as independent sessions | Sixteen scenarios and rubrics are supplied. The Grove walkthrough is an authored reference example, not a benchmark result. |
| Linux/Windows CI | Configured, not run here | Workflow includes all three operating systems. Local success does not establish remote runner results. |

## Research update in 0.2.0

The skill, research references, evaluation fixtures, and documentation changed in this release. The native sample code is unchanged; its build and runtime limitations above carry forward from 0.1.1.

| Check | Result | Evidence and limits |
| --- | --- | --- |
| Two-step design | Rendered and visually inspected | Original `assets/two-step.svg` was rasterized and inspected for typography, table readability, billing text and bounds. It is a design specification, not a running two-step native implementation. |
| Country purchase case | Awaiting evidence | Flags and a submission template are included. No app identity, production purchase records or skill attribution were supplied. |

## Flutter update in 0.3.0

Flutter 3.44.7 / Dart 3.12.2 were used from an isolated SDK/cache copy. Existing SwiftUI and Compose sources are unchanged. The Flutter demo adds an implemented two-step candidate; the original SVG remains a design illustration.

| Check | Result | Evidence and limits |
| --- | --- | --- |
| Flutter format/analyzer | Passed | Formatted Dart sources; analyzer reports no issues. |
| Flutter widget tests | Passed | Eight tests cover offer identity/back, duplicate purchase/restore, removed selected offer, empty/loading/error/retry, failure/disposal, system Back, 320px at 2× text, and demo close/reopen. |
| Flutter web build | Passed | Release web output compiled locally. No native or billing result is inferred. |
| Flutter visual review | Passed in browser | Both steps inspected at 390 × 844. Monthly selection, matching CTA/disclosure and demo result checked through browser semantics. Native screen readers remain untested. |
| Flutter native iOS/Android build | Not run | Generated host projects are included; widget/web success does not prove native builds. |
| Flutter device accessibility/store sandbox | Not run | No VoiceOver/TalkBack or real/sandbox billing integration. Demo callbacks only. |
| Flutter CI | Configured, not run remotely | Pinned SDK, formatting, analysis, widget tests and web build. |

## Documentation update in 0.3.1

External catalog connector instructions, associated video references and source-specific evaluation scenarios were removed. Research now uses supplied app artifacts and accessible first-party sources. The worked comparison is between authored Grove alternatives. Package structure, links and 16 evaluation fixtures were checked; all 15 installer tests passed. Native and Flutter code did not change, so their previously recorded checks were not rerun.

## Client compatibility

| Client | Discovery documentation checked | Installer file-copy tests | Actual client discovery + task execution |
| --- | --- | --- | --- |
| Claude Code | Yes | Passed | Unverified |
| Codex | Yes | Passed | Unverified |
| Cursor | Yes | Passed | Unverified |
| Antigravity | Yes | Passed | Unverified |

See [official setup sources](installation.md#official-sources). No client-specific hooks or tool grants are required. The skill is portable instruction content; models may make different design choices and their available image, code, and preview tools differ.

## Reproduce local checks

```sh
python3 scripts/check.py
python3 -m unittest discover -s tests -v
```

Run the SwiftUI sample checks on a Mac using [the sample instructions](../examples/swiftui/README.md). Use [the evaluation protocol](../evals/README.md) for client runs, then update this record with actual dates, client/model versions, artifacts, and outcomes. Never replace an unverified result with “passed” based solely on a planned check.
