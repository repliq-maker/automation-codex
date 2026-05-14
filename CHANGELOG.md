# Changelog

## Marketplace

- Added a robust LinkedIn Posts Comments run prompt for cases where Codex Settings shows the plugin/MCP installed but the current chat did not receive the skill/tool runtime injection.
- Added cached-skill and Apify tool-discovery fallback instructions to the LinkedIn Posts Comments runtime diagnostic.
- Added a copy/paste runtime test prompt to LinkedIn Posts Comments setup blocked-state output.
- Clarified LinkedIn Posts Comments setup idempotency so new setup chats detect completed Pass 1 state and continue without reinstalling or asking for another restart.
- Updated LinkedIn Posts Comments setup to avoid endless new-chat loops and create the Sheet when Google Drive is ready even if custom runtime surfaces are not visible in the setup chat.
- Added stale Apify MCP detection/replacement for non-matching LinkedIn post-search configs.
- Clarified LinkedIn Posts Comments setup restart guidance so users can type `continue` in the same setup chat after fully reopening Codex, with new chat as a fallback.
- Kept LinkedIn Posts Comments Apify MCP setup on the direct API-key path and explicitly disallowed switching setup to Apify OAuth.
- Added clearer setup handling for rare Codex platform secret-write blocks around private Apify MCP config.
- Clarified that LinkedIn Posts Comments setup should not ask for a second chat approval after the user provides an Apify key.
- Updated LinkedIn Posts Comments setup to avoid chat-permission prompts for required default setup actions.
- Added Google Drive OAuth reconnect guidance for refresh-token failures during setup.
- Added LinkedIn Posts Comments setup retries before asking users to act on transient MCP or connector failures.
- Added LinkedIn Posts Comments plugin-cache verification and access-denied cache recovery guidance to stop setup restart loops.
- Updated LinkedIn Posts Comments Apify MCP setup to use `harvestapi/linkedin-post-search`.
- Aligned root setup and production checklist docs with the setup-agent two-pass flow.
- Added explicit LinkedIn Posts Comments plugin enablement checks so marketplace-added does not get mistaken for plugin-installed.
- Added a setup restart-loop guard so users are not repeatedly told to restart when no install/config/auth state changed.
- Clarified that setup should not assume a general `codex plugin add` command exists.
- Tightened LinkedIn Posts Comments setup summaries to use clean visual icons instead of text labels like `[WARN]`.
- Updated LinkedIn Posts Comments setup to complete all bootstrap installs before one restart and to require the official Google Drive connector rather than MCP.
- Clarified that setup agents should perform marketplace upgrades directly and only hand commands to users as fallbacks.
- Updated LinkedIn Posts Comments setup to use a one-prompt, two-pass install/restart/verify flow before showing the run prompt.
- Changed LinkedIn Posts Comments to install by default from the marketplace and added cache/restart guidance for skill/MCP loading.
- Hardened LinkedIn Posts Comments so missing `Sheet folder` is never a blocker and falls back to root/default Drive.
- Added `Optional Sheet folder` to LinkedIn Posts Comments ready-to-paste run examples.
- Removed default `Sheet folder` examples from LinkedIn Posts Comments setup/run prompts; folder targeting is now documented as optional.
- Made LinkedIn Posts Comments folder placement optional so setup can continue when Google Drive tools can create Sheets but not folders.
- Clarified that LinkedIn Posts Comments setup does not collect keywords, filter, or post count; those are supplied per run.
- Updated the suggested Apify token description for LinkedIn Posts Comments setup.
- Added Apify dashboard token creation instructions to the LinkedIn Posts Comments setup docs.
- Removed Apify keys from LinkedIn Posts Comments daily run prompts; the setup prompt now owns MCP/key configuration.
- Updated the LinkedIn Posts Comments setup-agent prompt to do the Google Drive setup directly when tools allow it, instead of making users handle it manually.
- Added a LinkedIn Posts Comments setup-agent prompt for one-shot user onboarding and a visual readiness checklist.
- Clarified that real Apify keys should only be pasted in private Codex setup chats, not daily automations, screenshots, videos, public posts, or repo files.
- Aligned LinkedIn Posts Comments manifest capabilities and policy URLs with stricter official-style plugin metadata.
- Switched the LinkedIn Posts Comments marketplace entry back to the same-repo `local` source format shown in the repo marketplace docs.
- Clarified public install docs: use repo/Git URL, branch `main`, and optional sparse paths `.agents/plugins` plus `plugins/linkedin-posts-comments`; do not use raw `marketplace.json` as the marketplace source.
- Updated LinkedIn Posts Comments defaults for better B2B relevance: `Past Month`, `10-200` likes, `3-50` comments, and stricter off-topic filtering.
- Changed the first plugin entry to a Git-backed subdirectory source for external installs from the public marketplace repository.
- Added skill UI metadata and clearer `$linkedin-posts-comments` invocation guidance for the first plugin.
- Hardened the first plugin manifest with public repository, homepage, publisher, privacy, and terms metadata for external marketplace installs.
- Added marketplace manifest at `.agents/plugins/marketplace.json`.
- Set marketplace name to `automation-codex`.
- Set marketplace display name to `Automation Codex Maker Plugins`.
- Added `LinkedIn Posts Comments` as the first plugin under `plugins/linkedin-posts-comments`.

## LinkedIn Posts Comments

See `plugins/linkedin-posts-comments/CHANGELOG.md`.
