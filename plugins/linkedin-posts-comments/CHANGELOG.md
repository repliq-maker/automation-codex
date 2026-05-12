# Changelog

## 1.3.1

- Added skill UI metadata in `skills/linkedin-posts-comments/agents/openai.yaml`.
- Updated plugin default prompts to show the `$linkedin-posts-comments` invocation.
- Clarified that users should invoke the skill with `$linkedin-posts-comments` or a natural-language request, not a slash command.

## 1.3.0

- Simplified the public daily automation format to friendly labels.
- Added `Apify key` as the user-facing setup field.
- Hid MCP server naming from normal users; the plugin uses `apify-linkedin-post` internally.
- Kept advanced JSON aliases for power users.

## 1.2.0

- Added `targetPostCount` as the production volume control.
- Clarified that the target is the number of LinkedIn posts to scrape and append as rows.
- Clarified that each successfully scraped non-duplicate post row gets five comment options.
- Updated sheet headers to match the requested order: `Post linkedin`, `Authors`, `Comments`, `Likes`, `keywords`, `Comment 1-5`, `Status`.

## 1.1.0

- Added an initial dynamic worker-agent sizing model.
- Added `postsPerAgent` and `maxAgents` controls.
- Added guardrails to avoid runaway Apify usage.
- Added `DAILY_AUTOMATION_GUIDE.md` with a copy/paste daily automation payload.
- Updated examples and production checklist for volume controls.

## 1.0.0

- Added production setup docs.
- Added security guidance for Apify tokens.
- Added MCP setup template for `apify-linkedin-post`.
- Added daily automation payload example.
- Added worker output example with post text and summary fields.
- Added configurable traction thresholds.
- Added configurable brand and forbidden pitch terms.
- Clarified statuses: `reviewed`, `irrelevant`, `skipped`, and `commented`.
