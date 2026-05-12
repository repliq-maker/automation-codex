# Setup Guide

## Add The Marketplace

In Codex, use **Add marketplace** and paste:

```text
https://github.com/repliq-maker/automation-codex
```

If the UI expects a Git URL, use:

```text
https://github.com/repliq-maker/automation-codex.git
```

Codex should read:

```text
.agents/plugins/marketplace.json
```

Then install or enable the plugin you want from the marketplace list. The marketplace points to the plugin package with a Git-backed subdirectory source.

## Invoke A Plugin

For LinkedIn Posts Comments, use this at the top of a new chat or daily automation:

```text
Use $linkedin-posts-comments with this setup:
```

Do not rely on `/linkedin-posts-comments` or `@LinkedIn Posts Comments`; those may not be exposed for skill-only plugins in every Codex UI.

## First Plugin

The first plugin is:

```text
LinkedIn Posts Comments
```

Plugin package path:

```text
plugins/linkedin-posts-comments
```

See:

```text
plugins/linkedin-posts-comments/README.md
plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md
```

## User Requirements

For the LinkedIn plugin, each user needs:

- Google Drive connected in Codex.
- A Google Sheet with the required headers.
- An Apify account and private Apify key.
- A LinkedIn post scraper actor available through Apify.

Never share real Apify keys in GitHub, screenshots, videos, or community posts.
