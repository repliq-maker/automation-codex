# LinkedIn Posts Comments

Daily automation plugin for finding LinkedIn posts, filtering them for useful traction, drafting concise comment options, and appending the review queue to Google Sheets.

## Install In Codex

Use Codex's **Add marketplace** flow and paste this GitHub URL:

```text
https://github.com/repliq-maker/automation-codex
```

This repository is a Codex plugin marketplace. The marketplace manifest is at `.agents/plugins/marketplace.json`, and the plugin package is at `plugins/linkedin-posts-comments`.

This is a Codex skill plugin. It does not ship a standalone scraper; it instructs Codex to use the user's private Apify key, LinkedIn post scraper actor, and Google Drive connector.

## What It Does

1. Receives simple daily fields: sheet location, keywords, filter, number of posts, and Apify key.
2. Uses `apify-linkedin-post` internally when that MCP server already exists.
3. Builds private MCP setup guidance from the Apify key when that server does not exist.
4. Calculates how many worker agents to run from `Number of posts`.
5. Each worker researches up to `postsPerAgent` LinkedIn posts with the Apify LinkedIn post scraper.
6. Filters posts into `reviewed`, `irrelevant`, or `skipped` rows.
7. Generates five comment options for every successfully scraped non-duplicate post row.
8. Appends rows to the Google Sheet target provided by the daily automation.

## Requirements

- Codex with plugin/skill support.
- Node.js / `npx`, because the Apify MCP example uses `npx mcp-remote`.
- Apify account and API key. The plugin uses `apify-linkedin-post` internally for MCP setup.
- A LinkedIn post scraper actor that supports the fields shown in `agent.md`.
- Google Drive connector access to the destination folder and spreadsheet.
- A Google Sheets tab named `Comments`, unless you provide a different `sheetTab`.

Do not publish a real Apify API token inside this plugin, a screenshot, or a community post. Use placeholders in shared examples and have each user paste their own token in their private daily automation setup.

## Sheet Columns

Use these exact headers:

```text
Post linkedin
Authors
Comments
Likes
keywords
Comment 1
Comment 2
Comment 3
Comment 4
Comment 5
Status
```

Initial status values:

- `reviewed` for posts that pass the filters and have comment options.
- `irrelevant` for posts to avoid, including dead posts, buried posts, generic motivational content, and irrelevant AI content. These rows can still include comment options for review, but the status tells the user not to prioritize them.
- `skipped` for duplicates, scraper errors, missing data, or rows that cannot be safely evaluated.
- `commented` is reserved for the human/user after a comment is posted.

## Daily Automation Input

Use this simple format in the daily automation:

```text
Sheet folder: Codex_Automation
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / ai sdr / cold outreach / reply rate
Filter By: Past Week
Number of posts: 25
Apify key: YOUR_APIFY_KEY
```

The `Sheet file` value is the Google Sheets spreadsheet file name. The default tab is `Comments`; provide `Sheet tab` only when the tab is different. Users do not need to name the MCP server.

The skill accepts keywords as a JSON array, comma-separated string, slash-separated string, newline-separated string, or a plain natural-language request that clearly contains the keywords.

`filterBy` is mapped to the Apify actor's `postedLimit` setting. For example, `Past Week` maps to `week` unless the actor schema requires the display label.

`Number of posts` is the number of LinkedIn posts to scrape and append as rows. Each successfully scraped non-duplicate row gets five comment options and a status. Defaults:

- `Number of posts`: `25`
- `postsPerAgent`: `5`
- `maxAgents`: `10`

Agent count is calculated as `ceil(Number of posts / 5)`, capped by `maxAgents`. For example, `Number of posts: 25` starts up to 5 agents because each agent asks Apify for 5 posts.

## Community Setup

Share the GitHub repository URL with users:

```text
https://github.com/repliq-maker/automation-codex
```

Tell users to:

1. Add this GitHub repository as a Codex marketplace.
2. Install or enable the `LinkedIn Posts Comments` plugin from that marketplace.
3. Connect Google Drive in Codex.
4. Create a Google Sheet with the headers listed above.
5. Create an Apify token in their own Apify account.
6. Use the prompt from `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md`.
7. Replace `YOUR_APIFY_KEY`, sheet fields, keywords, filter, and number of posts.

See `SETUP.md` for the full walkthrough, `DAILY_AUTOMATION_GUIDE.md` for the copy/paste daily prompt, `PRODUCTION_CHECKLIST.md` before release, and `SECURITY.md` before sharing screenshots or templates.

## Files

- `.agents/plugins/marketplace.json` registers this repository as a Codex marketplace.
- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` registers the plugin metadata and skill path.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/SKILL.md` contains the exact Codex workflow.
- `plugins/linkedin-posts-comments/agent.md` contains the parent and worker-agent instructions used by the skill.
- `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md` gives a simple copy/paste daily automation payload.
