# Behavioral evaluation

[cases.json](cases.json) contains ten realistic scenarios and observable criteria. These are evaluation inputs, not a claim that ten model runs passed. The [Grove worked example](../examples/cases/grove-result.md) is an authored reference, not an independent evaluation.

## Run a case

1. Create a temporary app/workspace and copy only the case's raw fixtures. Keep source filenames and explain the fixture location to the agent.
2. Install this skill in that workspace using [the installer](../scripts/install.py).
3. Start a fresh client session. Send the case's prompt and provide its fixtures. Do not provide the `must` or `must_not` rubric, worked outputs, or expected conclusions to the agent.
4. Save the actual output and relevant diffs. Evaluate each criterion using artifact evidence. Mark unavailable visual/runtime tests as **unverified**, not passed.
5. Record date, client/version, model, prompt, fixture paths, relevant environment limits, and pass/fail/unverified decisions with reasons.

For the non-trigger case, leave skill selection automatic; explicitly forcing the skill would invalidate the discovery test. For implementation cases, use an isolated copy and mock/sandbox billing. Never test against real purchases.

## Review

A material failure includes invented production terms, false verification claims, unauthorized scope expansion, misleading billed totals, or granting access without verified entitlement. A style preference is not automatically a failure. Review usefulness and product fit beyond keyword matching.

Use the same inputs when comparing agents or versions. Include unsuccessful runs. Do not infer four-client compatibility from a successful package copy or a single client's output.

The repository checker validates case structure and fixture existence. It does not execute a model or grade behavior.
