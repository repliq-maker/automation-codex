# LinkedIn Posts Comments

Daily automation plugin for finding LinkedIn posts, filtering them for useful traction, drafting concise comment options, and appending the review queue to Google Sheets.

## Install In Codex

Use Codex's **Add marketplace** flow and paste this GitHub URL:

```text
https://github.com/repliq-maker/automation-codex
```

If the UI expects a Git URL, use:

```text
https://github.com/repliq-maker/automation-codex.git
```

Branch/ref:

```text
main
```

If Codex asks for partial paths or sparse checkout paths, include:

```text
.agents/plugins
plugins/linkedin-posts-comments
```

Do not paste the raw `marketplace.json` URL as the marketplace source. Use the repo URL or Git URL.

This repository is a Codex plugin marketplace. The marketplace manifest is at `.agents/plugins/marketplace.json`, and the plugin package is at `plugins/linkedin-posts-comments`. The marketplace entry points to the plugin package with a same-repo local source.

This is a Codex skill plugin. It does not ship a standalone scraper; it instructs Codex to use the user's private `apify-linkedin-post` MCP server, LinkedIn post scraper actor, and Google Drive connector.

## How To Invoke

After installing the plugin, use this at the top of a new chat or daily automation:

```text
Use $linkedin-posts-comments with this setup:
```

Then paste the daily fields below it.

Do not rely on `/linkedin-posts-comments` or `@LinkedIn Posts Comments`; skill-only plugins may not expose slash commands or `@` mentions in every Codex UI. The reliable trigger is `$linkedin-posts-comments` or a natural request that says to use the LinkedIn Posts Comments plugin.

## What It Does

1. Receives simple daily fields: sheet location, keywords, filter, and number of posts.
2. Uses `apify-linkedin-post` internally when that MCP server already exists.
3. Tells the user to run the setup prompt if the private Apify MCP server does not exist.
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
- Google Drive connector access to the destination spreadsheet. Folder placement is optional because some connector sessions can create/edit Sheets but cannot create folders or move files.
- A Google Sheets tab named `Comments`, unless you provide a different `sheetTab`.

Do not publish a real Apify API token inside this plugin, a screenshot, or a community post. Use placeholders in shared setup examples and have each user paste their own token only in their private setup chat.

If a user does not have an Apify key yet, they should open https://console.apify.com/, go to Settings -> API & Integrations, create a new token with a description like `Skool outreach Codex Automation Apify Key`, copy it from Personal API tokens, and paste it only in their private setup chat.

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
- `irrelevant` for posts to avoid, including dead posts, buried posts, generic motivational content, irrelevant AI content, hiring posts, operations posts, security/governance posts, and posts outside the sales/outreach context. These rows can still include comment options for review, but the status tells the user not to prioritize them.
- `skipped` for duplicates, scraper errors, missing data, or rows that cannot be safely evaluated.
- `commented` is reserved for the human/user after a comment is posted.

## Daily Automation Input

Use this simple format in the daily automation:

```text
Use $linkedin-posts-comments with this setup:
Optional Sheet folder: My Existing Folder
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / cold outreach / ai sdr / outbound sales / sales automation / reply rate / prospecting
Filter By: Past Month
Number of posts: 25
```

The `Sheet file` value is the Google Sheets spreadsheet file name. The default tab is `Comments`; provide `Sheet tab` only when the tab is different. `Optional Sheet folder` can be deleted when not needed. Add it only when targeting a specific existing folder. If the Google Drive connector cannot create folders or move files, the setup can create/find the spreadsheet in the default/root Drive location and still run. Users do not need to name the MCP server.

Users do not need to mention Google Drive or include their Apify key in normal runs. The Sheet fields tell the plugin where to write, and the setup prompt configures the private Apify MCP server once.

The setup prompt should not collect keywords, date filter, or post volume. Those are per-run values. Users can change `Sheet folder`, `Sheet file`, `Sheet tab`, `KEYWORDS`, `Filter By`, and `Number of posts` in any one-off chat or scheduled automation, and the plugin should follow the values from that current run. If no usable folder is supplied, the plugin can use the spreadsheet in the default/root Drive location.

The skill accepts keywords as a JSON array, comma-separated string, slash-separated string, newline-separated string, or a plain natural-language request that clearly contains the keywords.

`filterBy` is mapped to the Apify actor's `postedLimit` setting. For example, `Past Month` maps to `month` unless the actor schema requires the display label. `Past Month` is the recommended default for niche B2B keywords because it gives posts time to collect meaningful likes and comments.

`Number of posts` is the number of LinkedIn posts to scrape and append as rows. Each successfully scraped non-duplicate row gets five comment options and a status. Defaults:

- `Number of posts`: `25`
- `Filter By`: `Past Month`
- Traction window: `10-200` likes and `3-50` comments, with `500+` comments always treated as too buried.
- `postsPerAgent`: `5`
- `maxAgents`: `10`

Agent count is calculated as `ceil(Number of posts / 5)`, capped by `maxAgents`. For example, `Number of posts: 25` starts up to 5 agents because each agent asks Apify for 5 posts.

The plugin qualifies posts only when they are clearly about the target sales context: LinkedIn outreach, cold outreach, outbound sales, AI SDR, SDR workflows, prospecting, reply rates, lead generation strategy, sales automation, or related buying/selling motions.

## Community Setup

Share the GitHub repository URL with users:

```text
https://github.com/repliq-maker/automation-codex
```

For CLI installs, use:

```text
codex plugin marketplace add repliq-maker/automation-codex --ref main
```

For existing installs, update the marketplace before testing a new release:

```text
codex plugin marketplace upgrade automation-codex
```

Restart Codex or open a new chat after installing/upgrading the marketplace or adding the Apify MCP server. A saved marketplace/MCP config does not always update the current chat's loaded skill/tool list.

The setup prompt is intentionally one prompt with two passes. Pass 1 installs/connects tools and may require restart. Pass 2, after restart/new chat, verifies the loaded skill/tools and creates or verifies the Sheet, tab, and headers. Users should not run the automation until Pass 2 says `READY TO RUN`.

Tell users to:

1. Add this GitHub repository as a Codex marketplace.
2. Confirm `LinkedIn Posts Comments` is installed from that marketplace. It is marked `INSTALLED_BY_DEFAULT`; if the UI still shows it as available only, enable it manually.
3. Paste `SETUP_AGENT_PROMPT.md` into a private Codex chat so the setup agent can install/connect Google Drive when possible and create the Sheet, tab, and headers. Folder placement is optional/manual when the connector cannot create folders or move files.
4. Approve Google Drive sign-in only if Codex asks for user consent.
5. Create an Apify token in their own Apify account.
6. Use the prompt from `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md`.
7. Replace sheet fields, keywords, filter, and number of posts in the daily prompt. The Apify key belongs only in the private setup prompt.

For the easiest user onboarding flow, paste `SETUP_AGENT_PROMPT.md` into a new private Codex chat. It checks the marketplace, plugin, Apify MCP server, Google Drive connection, folder, spreadsheet, tab, and headers.

See `SETUP.md` for the full walkthrough, `SETUP_AGENT_PROMPT.md` for the copy/paste setup agent, `DAILY_AUTOMATION_GUIDE.md` for the copy/paste daily prompt, `PRODUCTION_CHECKLIST.md` before release, and `SECURITY.md` before sharing screenshots or templates.

## Files

- `.agents/plugins/marketplace.json` registers this repository as a Codex marketplace.
- `plugins/linkedin-posts-comments/.codex-plugin/plugin.json` registers the plugin metadata and skill path.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/SKILL.md` contains the exact Codex workflow.
- `plugins/linkedin-posts-comments/skills/linkedin-posts-comments/agents/openai.yaml` provides UI discovery metadata and a default `$linkedin-posts-comments` prompt.
- `plugins/linkedin-posts-comments/agent.md` contains the parent and worker-agent instructions used by the skill.
- `plugins/linkedin-posts-comments/SETUP_AGENT_PROMPT.md` gives users a one-shot setup agent prompt with a visual readiness checklist.
- `plugins/linkedin-posts-comments/DAILY_AUTOMATION_GUIDE.md` gives a simple copy/paste daily automation payload.
