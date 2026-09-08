# Optional Mobbin reference workflow

Use when researching a new paywall, a substantial redesign, or a user request that names Mobbin. The core skill remains free and works without Mobbin. Its [MCP service](https://docs.mobbin.com/mcp/introduction) requires an eligible paid Mobbin plan and OAuth authorization; do not make purchasing that service a prerequisite.

## Before calling tools

Discover the tools actually available in the current client. [Mobbin's features documentation](https://docs.mobbin.com/mcp/features) lists `search_screens`, `search_flows`, and `search_sections`. Read the exposed schemas instead of inventing arguments. For mobile paywalls, use screens and complete flows; website sections are not a substitute for a mobile flow.

If the connector is missing, unauthenticated, or inaccessible, report that once and continue with accessible first-party sources or user-supplied references. Do not claim to have queried MCP or viewed screenshots you did not retrieve. Do not silently install/authenticate a connector or upload private app data to research services.

## Research before layout

1. Establish category, platform, placement, audience, paid entitlement, and key unanswered design question from the app/brief.
2. Search for a small relevant set, typically 3–5 products when available. Prefer complete entry → value → offer flows over a large pile of isolated screens. Include a contrasting structure, not only designs that confirm the first idea.
3. Inspect returned screen images and flow sequence. Record source links, app, platform, visible locale, captured/checked date when available, number and purpose of steps, comparison structure, offer presentation, and exit/restore behavior. Unknown values stay unknown.
4. Return a **reference comparison table** before selecting the design. Use columns: `Product + source | context/platform | flow | comparison/value device | terms + navigation | adopt / avoid / why`. Keep reported performance in a separately labeled evidence column if supplied; screenshots alone do not establish it.
5. Synthesize patterns into the app's own brand and entitlements. Name material deviations and explain why they serve this product. A reference is not permission to copy its assets, text, logos, reviews, or numbers.

If only a source describes a screen, label it **source-described**, not visually inspected. Report the actual inspected sample size, never the provider's catalog size as work performed by the agent. A useful report is selective and traceable; do not bulk-export the catalog into this open-source repository.

## Separate two different tables

The **research comparison table** compares reference products and is a deliverable to the developer. The **in-app feature table** compares the user's actual free/paid or tier entitlements and is shown to app users. Both can be useful; neither should be filled with invented differences or competitor performance claims.

## Suggested request

```text
Use mobile-paywall and the connected Mobbin tools to research onboarding subscription
flows for this app's category and platform. Inspect relevant screens and full flows,
then compare sources, step purposes, free/paid tables, trial explanation, and navigation.
Propose a two-screen candidate and a single-screen control with reasons for any deviations.
Do not infer conversion rates from design popularity or the size of the library.
```

Setup links live in the repository's `docs/mobbin.md`; this installed reference is self-contained and does not require that documentation to operate.
