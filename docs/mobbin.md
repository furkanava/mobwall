# Mobbin MCP: optional, research first

Mobile Paywall does not require Mobbin. If you already have access, the skill can use it to retrieve references and compare complete journeys before designing. The [official introduction](https://docs.mobbin.com/mcp/introduction) lists Pro, Team and Enterprise access with OAuth; a free/open-source skill does not make a third-party service free.

## Connect using your client's official guide

| Client | Mobbin setup reference |
| --- | --- |
| Claude Code | [Claude Code CLI](https://docs.mobbin.com/mcp/clients/claude-code-cli) |
| Codex | [Codex App](https://docs.mobbin.com/mcp/clients/codex-app) or [client index](https://docs.mobbin.com/mcp/clients/overview) |
| Cursor | [Cursor](https://docs.mobbin.com/mcp/clients/cursor) |
| Antigravity | Choose the installed Antigravity edition in the [client index](https://docs.mobbin.com/mcp/clients/overview). |

The [MCP page](https://mobbin.com/mcp) publishes the remote endpoint `https://api.mobbin.com/mcp`. Follow the current guide and authorize through the client; never commit OAuth credentials. The installer in this repository does not change MCP settings or enroll you in a paid plan. Setup documentation was reviewed on 2026-09-08; client authentication and live Mobbin searches were not performed for this release.

## Use it

```text
Use mobile-paywall with Mobbin to research paywalls in my app's category.
Compare relevant full flows in a table with source links, context, step purposes,
free/paid comparison, offer clarity and tradeoffs. Show what you actually inspected.
Then design a two-screen onboarding candidate and explain how to test it against
the current single-screen offer. Keep my brand, entitlements and real prices.
```

Expected output: a bounded set of actual references, a comparative table, an original design, reasons for deviations, and a test plan. The [installed workflow](../skills/mobile-paywall/references/mobbin.md) handles missing access by continuing with accessible references. Do not fabricate a successful MCP search.

## What the numbers mean

The linked videos describe a 600,000+ general UI library and a separate 2,995-paywall review. Neither means this skill analyzed 690,000 paywalls or knows each screen's conversion rate. See the [source ledger](../skills/mobile-paywall/references/research.md) for timestamps, methodology and evidence limits.

All example artwork shipped here is original. No Mobbin screenshots, customer screenshots, or raw video transcripts are bundled under this repository's MIT license.
