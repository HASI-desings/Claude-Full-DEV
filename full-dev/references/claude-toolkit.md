# Claude Toolkit — use everything this session has

The same skill runs in **Claude Code** (terminal, files, git) and in the **Claude app** (web/desktop/mobile: web search, connectors, artifacts, sometimes a browser or a cloud workspace). At the start, check which of these exist. Tool names vary by surface (e.g. `mcp__Figma__get_screenshot`, `mcp__claude_ai_Figma__…`) — match by the suffix. If a tool is deferred, load it (ToolSearch / tool search) before declaring it missing.

| Capability | How to detect | Use it for | Fallback when missing |
|---|---|---|---|
| **Web search** | `WebSearch` / `web_search` | Finding references on inspiration sites, competitor research, current library versions/docs | Ask the user for links; work from known principles and say so |
| **Web fetch** | `WebFetch` / `web_fetch` | Reading a reference page, docs (GSAP, Next.js, Vercel), live guidelines (Vercel Web Interface Guidelines) | Ask the user to paste content |
| **Browser** (Claude in Chrome, built-in browser, cloud browser, or Playwright in a terminal) | `mcp__claude-in-chrome__*`, `*Claude_Browser*`, or `npx playwright` works | Visiting Awwwards/Pinterest/Supahero pages that need JS or login, **screenshotting references**, scroll-recording motion, testing your own build at mobile sizes, reading console errors | Web fetch for static pages; ask the user for screenshots/screen recordings |
| **Figma MCP** | tools like `get_design_context`, `get_screenshot`, `get_variable_defs`, `get_metadata`, `use_figma`, `create_new_file`, `send_code_to_figma`, `get_motion_context`, `search_design_system` | Read the user's designs exactly (layout, tokens, variables, motion); **create** the design-system file, variables and hero exploration frames yourself; push built UI back to Figma for review | Design system as code (`tokens.css`) + HTML preview pages / artifacts; user screenshots |
| **Image search** | `image_search` | Mood references for materials, textures, objects (Phase 2–3) — never copyrighted characters, artworks or people as final assets | Describe references in words |
| **Subagents** | `Agent` / `Task` tool | Parallel research (one per inspiration site), independent design critique, fresh-eyes QA and code review | Do it sequentially yourself |
| **Artifacts / Design canvas** | `Artifact` / claude-artifacts tools, Visualizer | Present inspiration boards, concept boards, 6–7 hero explorations, design-system preview, motion storyboards for approval | Self-contained HTML files sent to the user |
| **Terminal + filesystem** | `Bash`, `Read`, `Write`, `Edit` | Scaffold & run the project, run the Pro Max engine, Playwright tests, Lighthouse, git | Deliver files (complete contents at exact paths) for the user to place |
| **Vercel MCP** | `list_projects`, `create_project`, `create_deployment`, `get_deployment`, `get_runtime_logs`, `get_runtime_errors`, `create_project_env`, `add_project_domain`, `web_fetch_vercel_url` | Create project, set env vars, deploy, read build/runtime logs, verify the production URL | Vercel CLI (`vercel`, `vercel env`) or the dashboard via browser; else step-by-step instructions |
| **Supabase MCP** | `list_projects`, `apply_migration`, `execute_sql`, `list_tables`, `generate_typescript_types`, `get_advisors`, `deploy_edge_function`, `search_docs` | Schema migrations, RLS policies, typed client, security/perf advisors | SQL migration files + instructions |
| **GitHub** | `gh` authenticated, GitHub MCP, or a repo-attach tool | Create repo, commit, push, open PRs, connect to Vercel | Git commands for the user; or ask them to create an empty repo you can push to |
| **Memory / project files** | memory tools, `CLAUDE.md`, `docs/full-dev/` | Persist decisions across sessions | Keep everything in the deliverable docs |
| **21st.dev Magic MCP** | tools from a `magic`/`21st` MCP server (e.g. component search / builder / inspiration) | Search and pull community React components by effect name into the project; generate variants | Browse 21st.dev and copy via the shadcn registry URL; or build from `references/component-sources.md` sources. Setup (user's machine): `npx @21st-dev/cli@latest install claude --api-key <key>` with a key from 21st.dev/mcp |
| **ffmpeg** | `ffmpeg -version` in a terminal | Encode all-keyframe scrub video, extract frame sequences, posters (`tools/scroll-kit/*.sh`), convert screen recordings to GIF | Ask the user to run the scripts locally; or use pre-encoded assets; or online converters with the same settings (`-g 1`, no audio) |
| **Browser screen recording** | browser tool with GIF/recording, or Playwright `recordVideo` | Capture motion references of inspiration sites (Phase 3) and of our build for review (Phases 7, 10) | Screenshots at 0/25/50/75/100% of the scroll range; or ask the user for a phone screen recording |
| **Scheduled tasks** | scheduling / trigger tools | Phase 13: periodic uptime, Lighthouse, dependency and broken-link checks | Give the user a maintenance checklist |

## Operating principles

- **Do, don't describe.** If you can open the page, screenshot it, read the Figma node, run the build, or check production — do it, then report findings.
- **Evidence over assertion.** Every "it works / it matches" claim is backed by a screenshot, test output, log line or URL you actually checked.
- **Parallelise research.** In Phase 3 dispatch one subagent per inspiration source with the same brief (see phase-03), then merge.
- **Respect sites and IP.** Browse public pages normally; never bypass logins/paywalls; never lift another site's assets, code or copy into the build — references teach, they don't ship. Screenshots of other sites stay as private study material.
- **Mobile/no-terminal users** (e.g. working from a phone): deliver complete files at exact repo paths, prefer browser-based tooling (GitHub web, Vercel dashboard/MCP, StackBlitz/CodeSandbox), never assume they can run a command.
- **Keep secrets out of chat and code.** Ask the user to paste keys into Vercel/Supabase dashboards or `.env.local`, never into a message you will commit.
