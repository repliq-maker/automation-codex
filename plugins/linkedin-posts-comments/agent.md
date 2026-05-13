# Agent Instructions

These instructions support the `linkedin-posts-comments` skill. The parent agent reads this file before orchestration and passes the worker section to each sub-agent.

## Parent Agent

- Require friendly daily fields: `Sheet file`, `KEYWORDS`, `Filter By`, and `Number of posts`. `Sheet folder` / `Optional Sheet folder` is recommended but optional because some Google Drive connector sessions can create/edit Sheets without folder-create or file-move actions. Also accept camelCase aliases: `sheetFolder`, `sheetName`, `keywords`, `filterBy`, and `targetPostCount`.
- Never treat `Sheet folder`, `Optional Sheet folder`, or `sheetFolder` as a missing required field. If it is absent, continue with the spreadsheet in the connector's default/root Drive location.
- Use `apify-linkedin-post` as the internal Apify MCP server name. Do not ask normal users to name a server.
- If `apify-linkedin-post` already exists, use it. If it does not exist, stop and ask the user to run `SETUP_AGENT_PROMPT.md` first so the private MCP setup can be created. Never persist or echo real API tokens in plugin files, logs, or final summaries.
- Use the user's LinkedIn post scraper. Prefer an explicit `apifyActor` value from the automation payload when present. If no actor is provided, use the available Apify tools to resolve the LinkedIn post scraper before spawning workers.
- Normalize `filterBy` to the Apify actor's `postedLimit` value. For `Past Month`, use `month` unless the actor schema requires a different exact value. Accept `Past Week` as `week`, but prefer `Past Month` for niche B2B searches.
- Use configurable thresholds when provided. Defaults: `minLikes = 10`, `maxLikes = 200`, `minComments = 3`, `maxComments = 50`, `buriedCommentLimit = 500`.
- Use `brandName` and `forbiddenPitchTerms` when provided. Defaults: `brandName = ""` and `forbiddenPitchTerms = []`.
- Use `Number of posts` / `targetPostCount` as the number of LinkedIn posts to scrape and append as rows. Default: `25`.
- Use `postsPerAgent = 5` and `maxAgents = 10` unless the daily automation provides different values.
- Calculate worker count as `ceil(targetPostCount / postsPerAgent)`, clamped from `1` to `maxAgents`.
- Spawn the calculated worker sub-agents in parallel. Each worker gets a distinct keyword batch and researches up to `postsPerAgent` posts.
- If fewer than `targetPostCount` new non-duplicate rows are found and unused capacity remains below `maxAgents`, run one additional worker wave with fresh keyword combinations. Never exceed `maxAgents` total workers unless the user explicitly overrides it.
- Tell workers they are not alone in the workflow, must not write to Google Sheets, and must return normalized JSON only.
- Merge all worker outputs, deduplicate by post URL, and keep the first complete record for duplicates.
- Apply a final qualification check before writing rows:
  - Qualified: likes and comments are inside the configured target range.
  - Irrelevant: dead posts, posts with too many comments where a comment gets buried, generic motivational content, irrelevant AI content, hiring/job posts, operations/logistics/customer support posts, IAM/security/governance posts, anything outside the target traction range, missing required metrics, or any post with comments at or above `buriedCommentLimit`.
  - Qualified posts must be clearly about the user's target sales context, such as LinkedIn outreach, cold outreach, outbound sales, AI SDR, SDR workflows, prospecting, reply rates, lead generation strategy, sales automation, or buying/selling motions around those topics.
- Generate or repair five comment options in the parent for every successfully scraped non-duplicate post if a worker result is missing options or violates the comment rules.
- Append results to the requested spreadsheet. Use the requested Google Drive folder when it exists and connector tools support folder-scoped search or placement. If folder creation or file moving is unavailable, create/find the spreadsheet in the connector's default/root Drive location and continue.
- If the spreadsheet or tab cannot be found or created, stop with a clear blocker instead of writing to a guessed destination.
- Check existing `Post linkedin` values before appending and skip duplicates already present in the sheet.
- Return a short final summary with counts for researched, qualified, irrelevant, skipped, duplicates, and appended rows.

## Worker Agent

You are one of the calculated parallel workers for this run. You are not alone in this workflow. Do not edit files and do not write to Google Sheets. Your job is to run the Apify LinkedIn post scraper for your assigned keyword batch and return normalized JSON to the parent.

Use this Apify input body, replacing `maxPosts` with the assigned `postsPerAgent` value when the actor supports it, replacing `postedLimit` with the normalized filter setting, and replacing `searchQueries` with your assigned keyword batch:

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

Normalize every returned post into this shape:

```json
{
  "post_url": "https://www.linkedin.com/posts/...",
  "author": "Author Name",
  "post_text": "full post text when available",
  "post_summary": "one sentence summary of the post",
  "likes": 42,
  "comments": 12,
  "keywords": ["keyword used"],
  "qualified": true,
  "qualification_reason": "likes and comments are in the target range and the post is relevant",
  "comment_options": {
    "contrarian": "short lowercase comment",
    "tactical": "short lowercase comment",
    "consultative": "short lowercase comment",
    "short_agreement": "short lowercase comment",
    "personal_experience": "short lowercase comment"
  },
  "status": "reviewed"
}
```

For irrelevant posts, set `qualified` to `false`, set `status` to `irrelevant`, include a clear `qualification_reason`, include `post_text` or `post_summary` when available, and still provide five comment options when there is enough post context. Irrelevant posts include:

- dead posts with too little traction.
- posts with too many comments where a new comment will get buried.
- generic motivational content.
- irrelevant AI content.
- hiring, job opening, recruiting, or candidate-search posts.
- operations, logistics, fulfillment, or customer support posts that use words like `outbound` but are not about sales/outreach.
- IAM, security, identity, governance, or generic technical AI posts that mention `ai agents` but are not about sales, outreach, prospecting, SDR workflows, reply rates, lead generation, or sales automation.
- posts outside the assigned keywords or target audience.

Use `status: "skipped"` only for duplicates, missing data, scraper errors, or records that cannot be safely evaluated. Skipped rows can leave comment options blank.

Comment rules for every non-skipped post:

- lowercase only.
- short comments, maximum 280 characters each.
- no emojis.
- no hashtags.
- no corporate tone.
- no direct pitch for the configured brand or any term in `forbiddenPitchTerms`.
- no obvious ai-sounding phrasing.
- stay relevant to the post's actual content.
- do not invent personal details or claims.

Return only a JSON object with a `results` array. Do not add prose before or after the JSON.
