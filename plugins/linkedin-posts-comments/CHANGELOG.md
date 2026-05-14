# Changelog

## 1.3.34

- Added a robust runtime prompt for chats where Codex Settings shows the plugin/MCP installed but the skill or Apify tools are not injected into the chat.
- Clarified that this is a runtime loading surface issue, not necessarily a plugin cache or Sheet setup issue.

## 1.3.33

- Added cached-skill and Apify tool-discovery fallback instructions to the runtime test prompt.
- Clarified that setup should not be repeated when runtime loading is blocked after the Sheet is ready.

## 1.3.32

- Added a copy/paste runtime test prompt to the `SETUP SHEET READY, RUNTIME LOAD CHECK BLOCKED` output.
- Clarified that the small runtime test is diagnostic only and normal daily automation should wait for `READY TO RUN`.

## 1.3.31

- Made setup explicitly idempotent across same-chat `continue` and new-chat reruns.
- Clarified that already-correct marketplace/plugin/cache/MCP checks must not trigger another restart.
- Instructed new setup chats to infer Pass 2 from installed state and move to Sheet setup.

## 1.3.30

- Removed references to obsolete Apify MCP tools from public docs.
- Kept MCP validation focused on the required `harvestapi/linkedin-post-search` tool.
- Tightened setup continuation wording so a missing runtime surface no longer causes repeated setup/new-chat loops.

## 1.3.29

- Prevented setup from looping through new chats when plugin/MCP config and cache are correct but runtime surfaces are not visible in the setup chat.
- Allowed Sheet creation to proceed with Google Drive when marketplace/plugin/MCP config are verified, even if the custom skill or Apify tools are not visible in that setup chat.
- Added stale MCP detection so non-matching `apify-linkedin-post` configs are replaced with `harvestapi/linkedin-post-search`.

## 1.3.28

- Clarified that after a full Codex quit/reopen, users can type `continue` in the same setup chat instead of always opening a new chat.
- Kept the new-chat path as a fallback when the resumed chat still cannot see newly loaded plugin skills or MCP tools.

## 1.3.27

- Kept Apify setup on the direct API-key MCP path instead of introducing Apify OAuth.
- Clarified that a provided Apify key should be used for the private `apify-linkedin-post` MCP config without a second chat approval.
- Added a clearer blocker name for rare Codex platform secret-write blocks instead of switching setup methods.

## 1.3.26

- Clarified that a provided Apify key is authorization to create the private `apify-linkedin-post` MCP config.
- Prevented setup agents from asking for a second chat confirmation to store or persist the Apify key.
- Added guidance to use Codex platform approval flows directly when sensitive MCP config persistence is reviewed.

## 1.3.25

- Changed setup posture to act with recommended defaults instead of asking chat-permission for required setup steps.
- Clarified that the only normal conversational setup question is the Apify key when missing.
- Added a non-destructive default for conflicting Sheet headers instead of asking to overwrite user data.

## 1.3.24

- Added explicit handling for Google Drive OAuth refresh-token failures.
- Clarified that auto review cannot complete external Google OAuth consent or repair expired/revoked connector auth.
- Instructed setup to ask users to reconnect Google Drive when refresh token errors occur instead of retrying transient checks.

## 1.3.23

- Added a retry-before-user-action setup rule for transient MCP, Apify, Google Drive, and non-destructive CLI checks.
- Added a 10/20/30 second Apify MCP retry ladder before marking tools unavailable.
- Clarified that setup should use lightweight Apify capability checks, not the full scraper, during readiness verification.

## 1.3.22

- Added explicit plugin cache verification to the setup prompt.
- Changed setup summaries to separate plugin enabled from plugin cache current.
- Added a recovery path for Codex marketplace upgrades that fail with plugin-cache access denied errors.
- Prevented failed marketplace upgrades from being reported as successful setup steps.
- Changed the Apify MCP setup URL to use `harvestapi/linkedin-post-search`.

## 1.3.21

- Tightened public setup and daily-run wording so users rerun the setup prompt for missing skills instead of guessing manual upgrade steps.
- Replaced weak restart wording with the full quit/reopen/new chat rule.
- Clarified that Apify keys belong only in private setup chats, not daily automation prompts.

## 1.3.20

- Added explicit plugin install/enable verification for `linkedin-posts-comments@automation-codex`.
- Added private config fallback guidance when no custom plugin install command is available.
- Added official Google Drive plugin enablement guidance and reinforced that Google Drive must not be configured as MCP.
- Added a restart-loop guard so setup only asks for a full restart after the current pass actually changed install/config/auth state.
- Clarified that setup should not assume a general `codex plugin add` command exists.

## 1.3.19

- Tightened setup checklist instructions to use one visual icon per line.
- Explicitly disallowed `[OK]`, `[WARN]`, `[FAIL]`, and combined icon labels in setup summaries.

## 1.3.18

- Updated Pass 1 setup to complete all bootstrap installs/connects before asking for one global Codex restart.
- Clarified that Google Drive must use the official Codex Google Drive plugin/connector, not MCP.
- Restored visual checklist icons and added clearer full-quit/reopen Codex instructions.

## 1.3.17

- Clarified that the setup agent should run marketplace upgrades directly when possible.
- Kept CLI commands as manual fallbacks only for unavailable tools, permission failures, or required external approvals.

## 1.3.16

- Reworked setup guidance into a one-prompt, two-pass flow.
- Setup now stops after installing/upgrading marketplace, MCP, or connector surfaces and asks for restart/new chat before Sheet creation.
- Daily automation prompt is shown only after a second-pass verification confirms tools are loaded and the Sheet is ready.

## 1.3.15

- Changed the marketplace policy for LinkedIn Posts Comments to `INSTALLED_BY_DEFAULT`.
- Added explicit setup checks for "saved in config" versus "loaded in this chat" for both the plugin skill and Apify MCP tools.
- Added marketplace upgrade and restart/new-chat guidance for stale plugin caches.
- Removed Apify key wording from plugin default prompts.

## 1.3.14

- Hardened instructions so `Sheet folder` can never be treated as a missing required field.
- Clarified that missing folder input should fall back to the Sheet file in the connector's default/root Drive location.

## 1.3.13

- Added `Optional Sheet folder` to ready-to-paste run examples and accepted it as an alias for `Sheet folder`.

## 1.3.12

- Removed `Sheet folder` from default setup and run examples to avoid confusion when folder actions are unavailable.
- Clarified that folder targeting is an optional line for users who already have a specific folder they want to use.

## 1.3.11

- Made `Sheet folder` optional/recommended instead of blocking.
- Added fallback behavior for Google Drive connectors that can create/edit Sheets but cannot create folders or move files.

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
