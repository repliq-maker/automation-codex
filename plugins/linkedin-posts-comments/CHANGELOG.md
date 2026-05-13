# Changelog

## 1.3.10

- Removed per-run fields from the setup prompt input section.
- Clarified that keywords, date filter, post count, and even Sheet destination can be changed on any individual run.

## 1.3.9

- Updated the suggested Apify token description to `Skool outreach Codex Automation Apify Key`.

## 1.3.8

- Added minimal Apify dashboard instructions for users who need to create a token during setup.

## 1.3.7

- Removed `Apify key` from daily and weekly run prompts.
- Updated the skill contract so normal runs require an existing `apify-linkedin-post` MCP server created by the setup prompt.
- Clarified that API keys belong only in private setup/MCP configuration, not recurring automation prompts.

## 1.3.6

- Updated the setup-agent prompt to proactively install/connect Google Drive and create the target folder, spreadsheet, tab, and headers whenever Codex tools allow it.
- Clarified that users should only be asked for action when Apify key input, auth consent, restart, or an external failure blocks automation.

## 1.3.5

- Added `SETUP_AGENT_PROMPT.md` with a one-shot setup checklist for marketplace, plugin, Apify MCP, Google Drive, folder, spreadsheet, tab, and headers.
- Added clearer public-sharing guidance to keep real Apify keys out of screenshots, videos, community posts, and repository files.

## 1.3.4

- Aligned plugin capabilities with official examples: `Interactive`, `Read`, and `Write`.
- Switched privacy and terms URLs to raw public GitHub text URLs.

## 1.3.3

- Changed recommended default search window from `Past Week` to `Past Month`.
- Updated default qualification thresholds to `10-200` likes and `3-50` comments.
- Added stronger irrelevance rules for hiring, operations, security/governance, generic AI, and motivational posts.
- Updated keyword examples toward sales/outreach-specific searches.

## 1.3.2

- Added public repository, homepage, publisher, privacy, and terms metadata for stricter external marketplace installs.
- Updated the plugin developer name to `Repliq Maker`.

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
