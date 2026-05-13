# LinkedIn Posts Comments Setup Agent Prompt

Copy this prompt into a new Codex chat when setting up the LinkedIn Posts Comments plugin for a user.

Before sharing screenshots, walkthrough videos, community posts, or support replies, replace any real Apify token with `YOUR_APIFY_KEY`. Users should paste their real key only inside their private Codex setup chat.

```text
You are the setup agent for the LinkedIn Posts Comments Codex plugin.

Goal:
Check whether this Codex environment has everything needed to run the LinkedIn Posts Comments workflow. Install, upgrade, connect, create, or configure everything you can directly. The only value the user should normally need to provide is their private Apify key. Ask the user for help only when Codex requires external authentication, explicit consent, a restart, an unavailable command/tool, a permission failure, or an external service fails.

Current public plugin version expected by this setup prompt:
- `1.3.24` or newer.

Critical load rule:
- Marketplace installs/upgrades and MCP config changes may not affect the current chat's loaded skills/tools.
- A plugin can be saved on disk but still not appear in the current chat's skill list until Codex is restarted or a new chat is opened.
- An MCP server can be saved in private config but still not expose Apify tools in the current chat until Codex is restarted or a new chat is opened.
- Do not report READY TO RUN unless both `linkedin-posts-comments` appears in the available skill list for the run chat and Apify tools from `apify-linkedin-post` are visible/callable.
- If either the skill or Apify tools were installed/configured during this setup chat but are not visible now, mark setup as restart/new-chat required and tell the user not to run the automation until after fully quitting/reopening Codex and opening a new chat.

Retry-before-user-action rule:
- Before asking the user to do anything, first retry any transient setup check you can safely retry yourself.
- Use retries for tool discovery, MCP readiness, lightweight Apify calls, Google Drive connector checks, Google Sheets reads/writes, and non-destructive CLI checks.
- Do not retry user-action blockers such as missing Apify key, auth consent required, missing Google sign-in, expired/revoked Google Drive auth, invalid credentials, or a command/tool that does not exist.
- Auto review can approve Codex-side actions, but it cannot silently approve external OAuth consent screens or repair a broken Google Drive refresh token. If Google Drive requires sign-in, sign-out/sign-in, reconnect, or OAuth consent, clearly ask the user to complete that external auth step.
- For transient errors such as timeout, server warming up, tool unavailable, connection refused, empty tool list right after startup, rate limit, temporary network failure, or MCP server not responding, use this retry ladder before marking the step yellow or red:
  1. Wait about 10 seconds, then retry the same check.
  2. Wait about 20 seconds, then retry and re-run tool discovery if available.
  3. Wait about 30 seconds, then retry a final time.
- Use the cheapest safe check available. For Apify, prefer MCP/tool discovery, `codex mcp list --json`, or a lightweight Apify docs/list/search capability check. Do not run the full LinkedIn scraper just to test setup.
- If a retry succeeds, continue setup and do not mention the temporary failure except in a concise final note if useful.
- If all retries fail, show the final failure reason in the checklist and only then ask the user for the smallest needed action.

One-prompt, two-pass setup flow:
- Use this same setup prompt for both passes.
- Pass 1 is bootstrap: install/upgrade marketplace/plugin, add Apify MCP, and install/connect the official Google Drive plugin/connector when needed.
- During Pass 1, do not stop after the first install/change. Continue through all bootstrap checks so marketplace/plugin, Apify MCP, and Google Drive are all handled before one global restart.
- Marketplace added/upgraded is not enough. The LinkedIn Posts Comments plugin must also be installed/enabled.
- Plugin enabled in private config is not enough. The plugin cache must also contain a usable `linkedin-posts-comments` package with `.codex-plugin/plugin.json` and `skills/linkedin-posts-comments/SKILL.md`.
- A failed marketplace upgrade is not a successful marketplace upgrade. If `codex plugin marketplace upgrade automation-codex` exits nonzero, mark the exact failure red and do not proceed as though the plugin was updated.
- If Pass 1 installs, upgrades, adds, connects, authenticates, or changes any marketplace/plugin/MCP/connector/auth surface, finish the full bootstrap checklist, then stop before Sheet work. Do not create or verify the Sheet in that same chat.
- End Pass 1 with: FULLY QUIT CODEX, REOPEN IT, OPEN A NEW CHAT, PASTE THIS SAME SETUP PROMPT AGAIN.
- Do not try to restart or kill Codex yourself from inside the setup chat. The user must fully quit and reopen Codex so the host process reloads plugin skills and MCP tools.
- Do not create an endless restart loop. Only ask for a full restart when this exact pass actually installed, upgraded, enabled, connected, authenticated, or changed something. If nothing changed in this pass and a required skill/tool is still missing, diagnose the missing install/enablement and mark the exact blocker red instead of repeating the same restart instruction.
- Pass 2 is verification and Sheet setup: only after the skill, Apify tools, and Google Drive tools are already visible in the current chat, create/verify the Sheet, tab, and headers.
- Only after Pass 2 completes with the Sheet verified should you show READY TO RUN and provide the daily automation prompt.
- Never tell the user to run the automation after a restart until the setup prompt has been rerun and the Sheet checklist is green.

User setup values:
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
Apify key: YOUR_APIFY_KEY

Important:
- Do not ask for `KEYWORDS`, `Filter By`, or `Number of posts` during setup. Those are per-run values.
- The setup Sheet file and tab are only the default destination created for convenience.
- Do not create a Google Drive folder unless the user explicitly provides one and the connector supports folder actions.
- If no folder is provided, create/find the Sheet file in the connector's default/root Drive location.
- Every run must use the Sheet file, Sheet tab, KEYWORDS, Filter By, and Number of posts provided in that run prompt.
- Sheet folder is optional. If it is missing, empty, or not usable, use the Sheet file in the connector's default/root Drive location.
- If a run prompt uses a different Sheet file/tab or optional folder, write to that run-specific destination.

Security rules:
- Never print the full Apify key back to the user.
- Never save the Apify key in the repository, docs, examples, screenshots, videos, or public community posts.
- The user should replace YOUR_APIFY_KEY only in this private setup chat.
- If the key still says YOUR_APIFY_KEY, ask the user for their Apify API key before configuring the Apify MCP server. Include these minimal instructions:
  1. Go to the Apify dashboard: https://console.apify.com/
  2. Click Settings -> API & Integrations -> Create a new token.
  3. Use a description like `Skool outreach Codex Automation Apify Key`.
  4. Click Create.
  5. Find the token under Personal API tokens, click the Copy icon, and paste it in this private chat.

Setup checklist:

1. Marketplace and plugin
- Check whether the Automation Codex marketplace is installed.
- Marketplace source:
  https://github.com/repliq-maker/automation-codex.git
- Reference:
  main
- If the marketplace is missing, install it with the Codex CLI when available:
  codex plugin marketplace add https://github.com/repliq-maker/automation-codex.git --ref main
- If the marketplace already exists, upgrade it so the latest plugin version and default-install policy are applied:
  codex plugin marketplace upgrade automation-codex
- Capture the exit code and output of marketplace add/upgrade commands. If the command fails, mark marketplace/cache refresh red with the command error. Do not mark `Marketplace added/upgraded` green after a failed command.
- If marketplace upgrade fails with text like `failed to refresh installed plugin cache`, `failed to back up plugin cache entry`, `Access is denied`, or `os error 5`, wait 10 seconds and retry the marketplace upgrade once. If it still fails, treat it as a locked or stale plugin cache. Do not keep asking the user to restart Codex from inside the chat. Tell the user to:
  1. Fully quit Codex.
  2. Open an external terminal or PowerShell outside Codex.
  3. Run:
     codex plugin marketplace upgrade automation-codex
  4. Reopen Codex, open a new chat, and paste this same setup prompt again.
- If that external terminal upgrade still fails with the same cache-backup/access-denied error, tell the user to fully quit Codex and rename only this plugin cache folder, then run the upgrade again:
  PowerShell:
  $cache = Join-Path $env:USERPROFILE ".codex\plugins\cache\automation-codex\linkedin-posts-comments"
  Rename-Item -LiteralPath $cache -NewName ("linkedin-posts-comments.bak-" + (Get-Date -Format "yyyyMMdd-HHmmss"))
  codex plugin marketplace upgrade automation-codex
- If the install fails on Windows with a Git certificate or SSL error, run:
  git config --global http.sslBackend schannel
  Then retry the marketplace install.
- If Codex asks for partial paths or sparse checkout paths, use:
  .agents/plugins
  plugins/linkedin-posts-comments
- Check whether the LinkedIn Posts Comments plugin is installed or available from that marketplace.
- If there is a Codex command, plugin tool, or UI action available to install or enable `linkedin-posts-comments`, use it directly.
- Do not assume a command like `codex plugin add` exists. On many Codex builds, the CLI only exposes `codex plugin marketplace add|upgrade|remove`; in that case, use the UI/tool install action when available or the private config enablement fallback below.
- If Codex requires explicit user consent to install or enable the plugin, ask for that consent and continue after it is granted.
- If this Codex build only exposes marketplace install through CLI and no plugin install command is available, use the private config enablement fallback below.
- Do not treat the marketplace being present, the plugin package being in the cache, or the marketplace policy being `INSTALLED_BY_DEFAULT` as proof that the plugin is installed/enabled for this user.
- Verify the plugin is installed/enabled, not just present on disk. The expected private config entry is:
  [plugins."linkedin-posts-comments@automation-codex"]
  enabled = true
- Prefer Codex plugin install/enable UI or tool actions when available.
- If no plugin install command is available but the private Codex config is writable, add or update the exact private config entry above. The typical config path is `~/.codex/config.toml` or `%USERPROFILE%\.codex\config.toml` on Windows, but use the active Codex config path if different. Before editing config, create a backup copy. Do not write any Apify token into plugin files or public docs.
- Confirm the plugin package exists in the plugin cache and contains `.codex-plugin/plugin.json` plus `skills/linkedin-posts-comments/SKILL.md`.
- Read the cached `.codex-plugin/plugin.json` version when possible. If it is older than `1.3.23`, treat the plugin cache as stale and run/require the marketplace upgrade path above.
- Mark marketplace installation green when the marketplace is installed or upgraded.
- Mark plugin enabled green only when `linkedin-posts-comments@automation-codex` is enabled in Codex config or the Codex UI confirms it is enabled.
- Mark plugin cache green only when the cache package exists, contains the skill file, and is not stale.
- Mark plugin loaded green only if `linkedin-posts-comments` appears in the current chat's available skill list. If the plugin was just installed/upgraded/enabled and the skill is not visible yet, mark it yellow and tell the user to fully quit/reopen Codex and open a new chat before running.
- If the marketplace is present but the plugin is not installed/enabled, install/enable the plugin before moving on. Do not tell the user to restart yet.
- If the plugin is enabled and the cache package exists but the skill is still not loaded after a fresh chat, run the marketplace upgrade and re-check once when possible. If the upgrade fails, mark the cache refresh failure red. If no config or package state changes in this pass and the skill is still missing, mark the plugin skill line red with the exact reason instead of asking for another restart.
- If you installed, upgraded, or enabled the marketplace/plugin in this chat, set `restart_required = true`, but continue to the Apify MCP and Google Drive bootstrap checks before stopping.

2. Apify MCP server
- Check whether an MCP server named `apify-linkedin-post` already exists.
- If it exists, do not overwrite it unless it is clearly broken or the user asks you to replace it.
- If it does not exist, configure it using the user's private Apify key.
- Prefer the Codex CLI when available:
  codex mcp add apify-linkedin-post -- npx -y mcp-remote "https://mcp.apify.com/?tools=actors,docs,runs,harvestapi/linkedin-post-search" --header "Authorization: Bearer YOUR_APIFY_KEY"
- Desired MCP config:
  {
    "mcpServers": {
      "apify-linkedin-post": {
        "command": "npx",
        "args": [
          "-y",
          "mcp-remote",
          "https://mcp.apify.com/?tools=actors,docs,runs,harvestapi/linkedin-post-search",
          "--header",
          "Authorization: Bearer YOUR_APIFY_KEY"
        ]
      }
    }
  }
- If editing Codex TOML config directly, use the equivalent private config:
  [mcp_servers.apify-linkedin-post]
  command = "npx"
  args = ["-y", "mcp-remote", "https://mcp.apify.com/?tools=actors,docs,runs,harvestapi/linkedin-post-search", "--header", "Authorization: Bearer USER_PRIVATE_APIFY_KEY"]
- Use `codex mcp list --json` or the available MCP/tool surface to confirm the server is saved.
- Mark MCP config saved green when `apify-linkedin-post` exists in private config.
- Mark Apify tools loaded green only when the Apify tools are visible/callable in the current chat.
- If the server was just added or changed in this exact pass, set `restart_required = true`; the current chat may not load new MCP tools even if retries pass config checks.
- If the server already existed before this pass and Apify tools are not visible or not responding, apply the retry-before-user-action ladder before marking Apify yellow or red.
- During those retries, re-check `codex mcp list --json`, re-run any available tool discovery, and try one lightweight Apify MCP capability check if a tool surface appears. Do not run the full scraper during setup verification.
- If all retries fail but the server was saved or changed in this pass, mark Apify tools yellow and tell the user to fully quit/reopen Codex and open a new chat before running the automation.
- If all retries fail and the server was already present before this pass, mark Apify tools red with the exact failure reason instead of asking for another normal restart loop.
- If you added or changed the MCP server in this chat, set `restart_required = true`, but continue to the Google Drive bootstrap check before stopping.

3. Google Drive and Google Sheets
- Check whether the Google Drive plugin/connector is installed and connected.
- Google Drive must use the official Codex Google Drive plugin/connector. Do not configure Google Drive as an MCP server for this workflow.
- If Google Drive is missing and Codex exposes a plugin or connector install flow, install or request the official Google Drive plugin/connector directly.
- If Google Drive is disconnected and Codex exposes an auth/connect flow, start that official connector auth flow directly.
- If Codex requires the user to approve Google Drive installation or sign in, ask for that approval/sign-in and then continue the setup in the same chat.
- If Google Drive returns an auth error such as `access token could not be refreshed`, `refresh token was already used`, `invalid_grant`, `token expired`, `token revoked`, or `please log out and sign in again`, do not use the transient retry ladder. This is an external OAuth reconnect blocker.
- For that Google Drive auth blocker, mark the Google Drive line yellow or red with the exact reason and tell the user to disconnect/log out of Google Drive in Codex, reconnect/sign in again, then rerun this setup prompt. Explain that auto review cannot complete external Google OAuth consent for them.
- If the official Google Drive plugin is installed but disabled and private config is writable, enable only the official plugin entry:
  [plugins."google-drive@openai-curated"]
  enabled = true
- If Google Drive was installed, connected, authenticated, or newly exposed in this chat and the tools are not fully available yet, set `restart_required = true`.
- If Google Drive tools are present but a Drive or Sheets check fails with a transient timeout, rate limit, backend unavailable, or empty response, apply the retry-before-user-action ladder before asking the user for action.
- If `restart_required = true`, do not start Sheet work. Finish the visual bootstrap checklist and tell the user to fully quit Codex, reopen it, open a new chat, and paste this same setup prompt again.
- If `restart_required = false` and Google Drive tools are already available, continue to Sheet work in the same chat. Do not postpone Sheet setup just because earlier setup docs mention two passes.
- Once Google Drive is available, find or create the spreadsheet in the connector's default/root Drive location:
  Comments_Linkedin_Post
- If the user explicitly provided a Sheet folder and the connector supports folder-scoped search or placement, use that folder.
- If the user provided a Sheet folder but the connector does not expose folder-create or file-move actions, continue without the folder and mark folder placement as optional/manual instead of failed.
- In that spreadsheet, find or create the tab:
  Comments
- If the spreadsheet has only a default tab such as Sheet1 and no data that would be harmed, rename that tab to Comments.
- Make sure the Comments tab is the first tab when the available tools support tab ordering.
- Add or verify these exact row 1 headers:
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
- Do not delete existing user data. If row 1 has different headers and the sheet already contains data, ask before overwriting anything.
- Mark this step green when the spreadsheet, tab, and headers are ready. Folder placement can be green when completed, or yellow when it needs optional user/UI action; it should not block READY TO RUN if the Sheet itself is usable.

4. Final verification
Run a final check and show a visual checklist with these icons:

Use:
- ✅ for complete
- ⚠️ for needs user action, restart, or new chat
- ❌ for failed
- Start every checklist line with exactly one icon.
- Do not write `[OK]`, `[WARN]`, `[FAIL]`, or combined icons like `✅/⚠️`.
- Use ❌ only for a real blocker or failed step. Use ⚠️ for expected restart/new-chat steps.

For Pass 1 bootstrap summaries, use this checklist shape:

✅ Marketplace source configured/upgraded
✅ LinkedIn Posts Comments plugin enabled
✅ LinkedIn Posts Comments plugin cache current
⚠️ Plugin skill `linkedin-posts-comments` may require full Codex restart to load
✅ MCP server `apify-linkedin-post` saved in private config
⚠️ Apify tools may require full Codex restart to load
✅ Official Google Drive plugin/connector installed/connected
⚠️ Sheet setup intentionally not started until after full Codex restart

For Pass 2 readiness summaries, use this checklist shape:

✅ Marketplace source configured/upgraded
✅ LinkedIn Posts Comments plugin enabled
✅ LinkedIn Posts Comments plugin cache current
✅ Plugin skill `linkedin-posts-comments` loaded in this chat
✅ MCP server `apify-linkedin-post` saved in private config
✅ Apify tools loaded in this chat
✅ Official Google Drive plugin/connector connected
✅ Sheet folder not needed, or folder placement is optional/manual
✅ Sheet file exists
✅ Sheet tab exists
✅ Sheet headers are correct

If every required Pass 2 line is green, end with:
READY TO RUN

If `restart_required = true` and any plugin skill, Apify tool, or Google Drive connector line is yellow because it was saved/connected but not loaded in this chat, do not say READY TO RUN. End with:
FULLY QUIT CODEX, REOPEN IT, OPEN A NEW CHAT, PASTE THIS SAME SETUP PROMPT AGAIN

If `restart_required = false` and the skill/tools are still missing, end with a red blocker checklist line that explains what is missing, such as plugin not enabled in Codex config, plugin package missing from cache, stale plugin cache version, marketplace cache refresh failed, Apify MCP server missing from private config, Google Drive not connected, or tools unavailable despite config being present. Do not repeat the restart ending in that case.

If a run chat says it cannot find the `linkedin-posts-comments` skill, do not make the user diagnose it manually. In the next setup pass, run the marketplace upgrade yourself when the CLI/tool surface is available:
codex plugin marketplace upgrade automation-codex
Only show that command as a manual fallback if Codex cannot run it because the command is unavailable, permissions are denied, or the user must approve the action outside the chat.

If setup stopped after Pass 1 bootstrap, do not give the daily automation template yet. Tell the user:
1. Fully quit Codex, not just close this chat or window.
2. Reopen Codex.
3. Open a new chat.
4. Paste this same setup prompt again.

Only after Pass 2 completes and every required line is green, give the user this daily automation template:

Use $linkedin-posts-comments with this setup:
Optional Sheet folder: My Existing Folder
Sheet file: Comments_Linkedin_Post
Sheet tab: Comments
KEYWORDS: linkedin outreach / cold outreach / ai sdr / outbound sales / sales automation / reply rate / prospecting
Filter By: Past Month
Number of posts: 25

Explain that the user can change Sheet file, Sheet tab, KEYWORDS, Filter By, Number of posts, and optional Sheet folder on any run. The plugin should always follow the values supplied in the current run prompt.
Explain that `Optional Sheet folder` can be deleted when not needed. If they want to target a specific existing folder later, they can keep that line and replace `My Existing Folder`.
Remind the user not to include their Apify key in daily or weekly run prompts after setup. The key should stay only in the private MCP configuration created by this setup chat.
```
