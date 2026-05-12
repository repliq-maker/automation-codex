# Daily Automation Guide

Use this inside the daily automation prompt after the plugin is installed and the Apify MCP server is configured.

## Simple Daily Instructions

```text
Sheet folder: Codex_Automation
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / ai sdr / cold outreach / reply rate
Filter By: Past Week
Number of posts: 25
Apify key: YOUR_APIFY_KEY
```

## What To Change Daily

- `KEYWORDS`: the topics to search.
- `Number of posts`: the number of LinkedIn posts to scrape and append as rows.
- `Filter By`: the Apify date window, such as `Past Week`.

## Defaults Handled By The Plugin

- Internal MCP server name: `apify-linkedin-post`.
- Posts per worker agent: `5`.
- Maximum worker agents per run: `10`.
- Sheet headers and row order.
- Five comment styles per post.
- Irrelevant/dead/buried post filtering.

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
