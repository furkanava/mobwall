# Contributing

Useful contributions improve a decision or make a real workflow more reliable: a reproducible failure, a better example, a framework-specific integration note, or a verified client setup.

## Work locally

Edit the canonical skill in `skills/mobile-paywall/`; installer destinations are generated copies, not additional sources of truth. Keep `SKILL.md` concise and link conditional guidance from `references/`. Do not introduce required paid services, telemetry, provider credentials, or agent-specific shell execution.

Run:

```sh
python3 scripts/check.py
python3 -m unittest discover -s tests -v
```

For instruction changes, run relevant scenarios from [evals](evals/README.md) in a fresh agent session and attach the actual output or a redacted trace. Record client/model/version, date, fixtures, and checks performed. Passing package checks is not a behavioral evaluation.

For SwiftUI changes, type-check with an iOS SDK and inspect the screen on compact and standard devices with larger text. Clearly distinguish compilation, visual inspection, and store-sandbox testing.

For native Android changes, build `examples/android` with `./gradlew :app:assembleDebug` and inspect the affected screen in an emulator/device when available. Keep UI-build and Google Play purchase-test results separate.

## Examples and evidence

Use original, fictional, or explicitly authorized assets. Mark fictional prices and results. Include a reproducible input, output, design rationale, and verification limits. Never include private app code, receipts, customer data, or keys in a public issue.

Conversion claims need an attributable experiment with a defined population, metric, and observation window. Visual before/after examples can stand on their own without revenue claims.

## Pull requests

Explain the concrete problem, resulting behavior, and validation. Add a focused regression test when changing installer behavior. Prefer a narrow decision rule over a growing list of universal requirements. Contributions are provided under the repository's [MIT license](LICENSE).
