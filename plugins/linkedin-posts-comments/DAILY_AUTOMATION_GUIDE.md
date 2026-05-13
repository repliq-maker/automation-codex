# Daily Automation Guide

Use this inside the daily automation prompt after the setup prompt has installed the plugin and configured the Apify MCP server.

## Simple Daily Instructions

```text
Use $linkedin-posts-comments with this setup:
Optional Sheet folder: My Existing Folder
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / cold outreach / ai sdr / outbound sales / sales automation / reply rate / prospecting
Filter By: Past Month
Number of posts: 25
```

## What To Change Daily

- `KEYWORDS`: the topics to search.
- `Number of posts`: the number of LinkedIn posts to scrape and append as rows.
- `Filter By`: the Apify date window. Use `Past Month` by default for niche B2B keywords.

Use `$linkedin-posts-comments` as the reliable trigger. Do not rely on a slash command or `@LinkedIn Posts Comments` mention; skill-only plugins may not expose those in every Codex UI.

You do not need to mention Google Drive or paste the Apify key in normal runs. The Sheet fields tell the plugin where to write, and the setup prompt already configured the private Apify MCP server.

You can change `Sheet folder`, `Sheet file`, `Sheet tab`, `KEYWORDS`, `Filter By`, and `Number of posts` for any one-off or scheduled run. The plugin follows the values in the current run prompt.

`Optional Sheet folder` can be deleted when not needed. Use it only when targeting a specific existing folder. If folder placement is not available through the Google Drive connector, the plugin can still use the named Sheet file in the default/root Drive location.

## Defaults Handled By The Plugin

- Internal MCP server name: `apify-linkedin-post`.
- Posts per worker agent: `5`.
- Maximum worker agents per run: `10`.
- Sheet headers and row order.
- Five comment styles per post.
- Irrelevant/dead/buried post filtering.
- Default qualification window: `10-200` likes and `3-50` comments.
- Stronger relevance filtering against hiring, operations, security/governance, generic AI, and motivational posts.

Default formula:

```text
agentCount = ceil(Number of posts / 5)
```

Example:

```text
Number of posts 25 / 5 = 5 agents
```

## Recommended Defaults

- Light daily run: `Number of posts: 10`.
- Normal daily run: `Number of posts: 25`.
- Larger review queue: `Number of posts: 50`, if the user's Apify budget supports it.

Each successfully scraped non-duplicate post gets one sheet row and five comment options. Use `Status` to decide which comments to actually use.
