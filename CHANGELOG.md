# Changelog

## Marketplace

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
