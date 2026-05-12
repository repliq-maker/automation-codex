---
name: linkedin-posts-comments
description: Run the LinkedIn Posts Comments daily automation: use Apify to scrape a requested number of recent LinkedIn posts from supplied keywords and filter setting, generate five short comment options per scraped row, mark irrelevant posts, and append rows to the provided Google Sheet.
---

# LinkedIn Posts Comments

Use this skill when the user or a daily automation asks to research LinkedIn posts for a supplied keyword list and prepare comment options in Google Sheets.

Before running, read `../../agent.md` and follow its parent/worker instructions. The sub-agent workflow described there is part of this skill's required behavior.

## Required Inputs

- `Sheet folder`: Google Drive folder that contains the spreadsheet, such as `Codex_Automation`.
- `Sheet file`: Google Sheets spreadsheet file name, such as `Comments_Linkedin_Post`.
- `KEYWORDS`: a slash/comma/newline-separated keyword string.
- `Filter By`: Apify actor date filter, such as `Past Week`.
- `Number of posts`: number of LinkedIn posts to scrape and append as rows.
- `Apify key`: user's private Apify API key.
- Optional `Sheet tab`: Google Sheets tab name. Defaults to `Comments`.

Also accept JSON/camelCase aliases for automation power users:

- `sheetFolder` for `Sheet folder`.
- `sheetName` for `Sheet file`.
- `sheetTab` for `Sheet tab`.
- `keywords` for `KEYWORDS`.
- `filterBy` for `Filter By`.
- `targetPostCount` for `Number of posts`.
- `apifyApiKey` for `Apify key`.

Advanced optional fields:

- Optional `apifyActor`: the Apify actor name for the user's LinkedIn post scraper, such as `user/linkedin-post-scraper`.
- Optional `brandName`: brand/company name to avoid pitching in comments.
- Optional `forbiddenPitchTerms`: words or phrases that must not appear in comments. Defaults to an empty list.
- Optional thresholds: `minLikes`, `maxLikes`, `minComments`, `maxComments`, `buriedCommentLimit`.
- Optional scale controls: `postsPerAgent`, `maxAgents`.

If any required field is missing, ask for the missing friendly-label field and do not run Apify. Do not ask normal users for MCP server names.

## Required Tools

- Apify MCP server named internally as `apify-linkedin-post`, using the user's Apify key and LinkedIn post scraper.
- Google Drive / Google Sheets connector for the destination spreadsheet.
- `spawn_agent` for dynamically sized parallel worker batches.

Use `apify-linkedin-post` as the internal MCP server name. If that server already exists, use it. If it does not exist, build the MCP setup from `Apify key` using the template in `mcp.example.json` and tell the user to add it to their private Codex MCP setup, then rerun. Do not ask the user to choose or name an MCP server. Do not store the key in plugin files. Do not include keys in final responses.

If the exact Apify actor is not supplied, resolve it with available Apify tools before spawning workers. Prefer a LinkedIn post scraper whose input supports the fields in the body below. Do not use a generic web browser scrape as a replacement when Apify is available.

## Apify Scraper Body

Every worker must use this body, replacing `maxPosts` with the assigned `postsPerAgent` value when the actor supports it, replacing `postedLimit` with the normalized `filterBy` setting, and replacing `searchQueries` with its assigned keyword batch:

```json
{
  "maxPosts": 5,
  "maxReactions": 5,
  "postNestedComments": false,
  "postNestedReactions": false,
  "postedLimit": "FILTER_BY_SETTING",
  "scrapeComments": false,
  "scrapeReactions": false,
  "searchQueries": [
    "ADD_RELEVANT_KEYWORDS"
  ],
  "sortBy": "relevance"
}
```

## Workflow

1. Normalize the daily automation input.
   - Map `Sheet folder` / `sheetFolder` to the Drive folder.
   - Map `Sheet file` / `sheetName` to the spreadsheet file name.
   - Map `Sheet tab` / `sheetTab` to the tab name, defaulting to `Comments`.
   - Map `KEYWORDS` / `keywords` to the keyword string.
   - Map `Filter By` / `filterBy` to the actor's `postedLimit` setting. For `Past Week`, use `week` unless the actor schema requires a different exact value.
   - Map `Number of posts` / `targetPostCount` to the number of LinkedIn posts to scrape and append as rows. Default to `25`.
   - Map `Apify key` / `apifyApiKey` to the user's private Apify token.
   - Use internal MCP server name `apify-linkedin-post`.
   - Use configurable thresholds when present; otherwise use the default traction thresholds.
   - Use `brandName` and `forbiddenPitchTerms` when present to block direct pitch language.
   - Use `postsPerAgent = 5` and `maxAgents = 10` unless provided.
2. Confirm MCP access.
   - If `apify-linkedin-post` exists, use it.
   - If it does not exist and `Apify key` is supplied, generate the private MCP config using that key and the `mcp.example.json` structure, ask the user to add it to Codex, then rerun.
   - If neither an existing server nor `Apify key` is available, stop and ask for `Apify key`.
   - Never save real MCP credentials or API tokens into plugin files, logs, or final summaries.
3. Normalize the keyword input.
   - Trim whitespace.
   - Remove empty items.
   - Split slash-separated strings such as `linkedin outreach / ai sdr / cold outreach / reply rate`.
   - Preserve the exact keyword text for the `keywords` sheet column.
4. Resolve the Apify LinkedIn post scraper actor.
   - Use an explicit `apifyActor` from the automation payload when present.
   - If absent, use the Apify MCP tools to find the user's LinkedIn post scraper and confirm the input fields match the required body.
5. Calculate worker-agent batches.
   - `agentCount = ceil(targetPostCount / postsPerAgent)`.
   - Clamp `agentCount` between `1` and `maxAgents`.
   - Each worker researches up to `postsPerAgent` posts.
   - If the actor only supports `maxPosts = 5`, keep `postsPerAgent` at `5` even when a larger value is supplied.
   - If fewer keywords are supplied than agents, create distinct search batches by varying keyword combinations/order without inventing unrelated topics.
6. Spawn the calculated worker agents in parallel.
   - Start one wave with `agentCount` workers.
   - If fewer than `targetPostCount` new non-duplicate rows are found and unused agent capacity remains, run one additional wave with fresh keyword combinations.
   - Never exceed `maxAgents` total workers in one automation run unless the user explicitly overrides it in the same prompt.
7. Wait for worker outputs and parse their JSON `results`.
8. Deduplicate by `post_url`.
9. Re-check qualification and irrelevance rules in the parent.
10. Generate or repair five comment options for every successfully scraped non-duplicate post row, whether its status is `reviewed` or `irrelevant`.
11. Append non-duplicate rows to the target Google Sheet.
12. Report a concise summary.

## Qualification Rules

Default qualified posts must have all of:

- `20 <= likes <= 150`
- `5 <= comments <= 40`
- `comments < 500`

Override those defaults only when the daily automation provides threshold fields.

Mark these posts as `irrelevant`:

- dead posts with too little traction.
- posts with too many comments where a new comment gets buried.
- posts with `comments > 40`, especially `comments >= 500`.
- generic motivational content.
- irrelevant AI content.
- posts that do not match the supplied keywords or target buying context.
- posts missing required metrics.

Rows that pass the filters start with `Status` set to `reviewed`. Rows that fail the filters start with `Status` set to `irrelevant`. Use `skipped` for duplicates, scraper errors, or rows that cannot be safely evaluated.

## Comment Generation

Generate these five columns for every successfully scraped non-duplicate post:

- `Comment 1`: contrarian comment.
- `Comment 2`: tactical comment.
- `Comment 3`: consultative comment.
- `Comment 4`: short agreement comment.
- `Comment 5`: personal experience comment.

All comments must follow these rules:

- lowercase only.
- short comments.
- maximum 280 characters.
- no emojis.
- no hashtags.
- no corporate tone.
- no direct pitch for `brandName` or any term in `forbiddenPitchTerms`.
- no obvious ai-sounding phrasing.
- relevant to the post's content.
- no invented personal details.

Leave comment columns blank only for skipped posts that cannot be safely evaluated.

## Google Sheets Target

Write to:

- Google Drive folder: the provided `sheetFolder`.
- Spreadsheet: the provided `sheetName`.
- Sheet tab: the provided `sheetTab`, defaulting to `Comments`.

Use these exact column headers, in this order:

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

Before appending:

- Read existing `Post linkedin` values and skip duplicates.
- If the header row is missing, create it with the exact headers above.
- If the spreadsheet or tab cannot be found, stop with a clear blocker instead of writing to a guessed destination.
- Do not overwrite rows whose status is already `commented`.

## Final Response

Keep the final response short. Include:

- researched post count.
- qualified count.
- skipped count.
- irrelevant count.
- duplicate count.
- appended row count.
- target post count.
- worker-agent count used.
- any blocker, such as missing actor, missing folder, missing spreadsheet, or unavailable connector.
