# Changelog

## Marketplace

- Updated the suggested Apify token description for LinkedIn Posts Comments setup.
- Added Apify dashboard token creation instructions to the LinkedIn Posts Comments setup docs.
- Removed Apify keys from LinkedIn Posts Comments daily run prompts; the setup prompt now owns MCP/key configuration.
- Updated the LinkedIn Posts Comments setup-agent prompt to do the Google Drive setup directly when tools allow it, instead of making users handle it manually.
- Added a LinkedIn Posts Comments setup-agent prompt for one-shot user onboarding and a visual readiness checklist.
- Clarified that real Apify keys should only be pasted in private Codex setup chats or daily automations, not screenshots, videos, public posts, or repo files.
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
