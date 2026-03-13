<div align="center">

# Rising Tides Skills Pack

**187 expert skills for Claude Code. One command to install.**

[![Skills](https://img.shields.io/badge/Skills-187-blue?style=for-the-badge)](#whats-included)
[![Plugins](https://img.shields.io/badge/Plugins-35-purple?style=for-the-badge)](#whats-included)
[![Platforms](https://img.shields.io/badge/Platforms-Mac%20%7C%20Linux%20%7C%20Windows-green?style=for-the-badge)](#install)
[![Security](https://img.shields.io/badge/Security-AUDITED-brightgreen?style=for-the-badge)](#security)

</div>

---

## What Is This?

Rising Tides is a curated collection of **187 skills** that make Claude Code dramatically better at real-world tasks. Instead of starting from scratch every time, Claude gets expert-level frameworks, workflows, and patterns — instantly.

**Skills are knowledge files** that teach Claude how to approach specific tasks. When you say "build me a React component," Claude automatically loads the `react-dev` skill, which contains expert React patterns, TypeScript best practices, and testing strategies. When you say "audit this for security," Claude loads the `security-audit` skill with a comprehensive checklist covering OWASP Top 10, dependency scanning, and more.

You don't need to learn anything new. Just use Claude Code the way you already do — the skills activate automatically based on what you ask for.

---

## Install

Pick your platform. One command does everything.

### Mac

> **Do NOT use `sudo`.** The script prompts for your password only when needed (like installing Homebrew).

```bash
curl -fsSL https://raw.githubusercontent.com/SunsetSystemsAI/setup/main/mac.sh -o /tmp/setup-rt.sh && bash /tmp/setup-rt.sh
```

### Linux / WSL2

```bash
curl -fsSL https://raw.githubusercontent.com/SunsetSystemsAI/setup/main/linux.sh -o /tmp/setup-rt.sh && bash /tmp/setup-rt.sh
```

### Windows

Open **PowerShell as Administrator**, then paste:

> **Note:** Requires winget. Windows 11 includes it by default. Windows 10 users: install [App Installer](https://apps.microsoft.com/detail/9nblggh4nns1) from the Microsoft Store first.

```powershell
irm https://raw.githubusercontent.com/SunsetSystemsAI/setup/main/windows.ps1 -OutFile "$env:TEMP\setup-rt.ps1"; & "$env:TEMP\setup-rt.ps1"
```

---

## What the Setup Script Does

Full transparency — here's exactly what runs on your machine:

### Step 1: Install GitHub CLI
The script installs `gh` (GitHub's official CLI) if you don't have it:
- **Mac:** via Homebrew (installs Homebrew first if needed)
- **Linux:** via your package manager (apt, dnf, yum, or pacman)
- **Windows:** via winget

### Step 2: Authenticate with GitHub
Runs `gh auth login` so you can access the private skills repository. You'll sign in through your browser — the script never sees your password.

### Step 3: Install Prerequisites
Installs development tools if you don't already have them:
- **Node.js 20** — Required for Claude Code and MCP servers
- **Git** — For version control
- **Python 3** — For some MCP tools
- **Mac only:** Xcode Command Line Tools, Homebrew, jq

The script checks what's already installed and **skips anything you have**. It won't reinstall or overwrite your existing tools.

### Step 4: Install Claude Code
Installs Anthropic's official Claude Code CLI if not already present, then configures:
- **Status line** — Shows model, cost, and context usage
- **Tool Search** — Keeps context efficient by deferring MCP tool schemas

### Step 5: Install Skills Pack
Copies files to your `~/.claude/` directory:

```
~/.claude/
├── skills/              # 187 skill files (knowledge + workflows)
├── plugins/             # 35 plugin bundles (skill + MCP configs)
├── commands/            # Slash commands (e.g., /recommend-skills)
├── SKILLS_INDEX.json    # Discovery index (how Claude finds skills)
├── MCP_REGISTRY.md      # MCP configuration reference
└── ATTRIBUTION.md       # Credits to original skill authors
```

**Nothing is modified outside `~/.claude/`.** Your existing projects, configs, and tools are untouched.

### Step 6: Cleanup
Deletes the temporary clone of the private repo. Nothing lingers.

---

## Getting Started

After installation, open a terminal and run `claude` to start Claude Code. Then try:

### Get Personalized Recommendations
```
/recommend skills
```
Claude scans your project and suggests which skills are most relevant.

### Just Describe What You Need
```
Help me build a React login form
```
Claude automatically discovers and loads the `react-dev` skill — no extra commands needed.

### Invoke Skills Directly
```
/security-audit check this codebase
/copywriting write a headline for my landing page
/stripe-integration set up payments
```

### How Auto-Discovery Works

You don't need to memorize skill names. Claude matches what you say to the right skill:

| You say... | Claude loads... |
|-----------|----------------|
| "build a React component" | `react-dev` — React 18-19 + TypeScript patterns |
| "write a headline" | `copywriting` — PAS/AIDA/BAB frameworks |
| "set up Stripe payments" | `stripe-integration` — CLI auth + checkout flows |
| "deploy to Vercel" | `vercel-deployment` — CLI commands + env config |
| "audit for security" | `security-audit` — OWASP Top 10 checklist |
| "create an API" | `api-designer` — REST/GraphQL design patterns |
| "write tests" | `test-master` — Testing strategies + coverage |
| "debug this issue" | `debugging` — Scientific method root cause analysis |

---

## What's Included

### 187 Skills Across 19 Categories

| Category | Skills | Highlights |
|----------|--------|------------|
| **Security** | 33 | Next.js hardening, Semgrep rules, YARA rules, smart contract auditing, code review |
| **Backend** | 20 | Django, FastAPI, Rails, NestJS, Spring Boot, SaaS starters |
| **Workflow** | 14 | Git workflow, debugging, code review, session handoffs |
| **Marketing** | 13 | Copywriting, SEO audit, email sequences, pricing strategy |
| **Languages** | 13 | Python, Go, Rust, C++, Java, Kotlin, Swift, TypeScript, SQL |
| **Integrations** | 12 | n8n workflows, Datadog, Jira, Salesforce, Perplexity |
| **Documentation** | 11 | READMEs, Mermaid diagrams, DOCX, PDF, PPTX, XLSX |
| **DevOps** | 10 | Kubernetes, Terraform, Docker, GitHub Actions, GitOps |
| **Architecture** | 10 | C4 diagrams, MCP builder, microservices, plugin forge |
| **Frontend** | 9 | React, Angular, Vue, design systems, Shopify |
| **Design** | 8 | Brand guidelines, video generator, SVG logos, Remotion |
| **Utilities** | 8 | Skill recommendations, humanizer, memory graph |
| **CRO** | 7 | A/B testing, forms, onboarding, paywalls, popups |
| **Testing** | 6 | Jest, Playwright, property-based testing |
| **Communication** | 4 | Meeting updates, feedback, professional writing |
| **Deployment** | 4 | Vercel, Netlify, Google Cloud, AWS cost optimization |
| **AI/ML** | 2 | Fine-tuning, prompt engineering |
| **Mobile** | 2 | Flutter, React Native |
| **Payments** | 1 | Stripe integration |

### 35 Plugins

Plugins bundle a skill with its MCP (Model Context Protocol) configuration for zero-setup tooling:

| Plugin | What It Does |
|--------|-------------|
| `react-dev-plugin` | React skill + live docs via Context7 |
| `webapp-testing-plugin` | Testing skill + Playwright browser control |
| `video-generator-plugin` | Video skill + Remotion rendering |
| `git-workflow-plugin` | Git skill + GitHub API operations |
| `stripe-plugin` | Payments skill + Stripe CLI integration |
| And 30 more... | |

### 9 CLI Integrations

Skills that work with external command-line tools:

| CLI | What It Does |
|-----|-------------|
| GitHub (`gh`) | Repos, PRs, issues, Actions |
| Stripe (`stripe`) | Payments, products, webhooks |
| Vercel (`vercel`) | Deployment, env vars, domains |
| Netlify (`netlify`) | Deployment, functions |
| Firebase (`firebase`) | Firestore, Auth, Hosting |
| Supabase (`supabase`) | Database, auth, realtime |
| Google Cloud (`gcloud`) | Cloud Run, Functions |
| Jira (`jira`) | Issues, sprints, workflow |
| Datadog | Logs, metrics, monitoring |

### 16 MCPs (Model Context Protocol)

Rich API integrations that give Claude deeper capabilities:

| MCP | Purpose |
|-----|---------|
| Context7 | Live, up-to-date library documentation |
| Playwright | Browser automation and testing |
| Remotion | Programmatic video generation |
| GitHub | GitHub API operations |
| Memory | Persistent knowledge across sessions |
| And 11 more... | |

---

## Context Efficiency

Skills don't bloat Claude's context. The system uses progressive disclosure:

- **At startup:** Only skill descriptions load (~100 tokens each, ~15k total = ~7% of context)
- **When you ask:** Full skill content loads on demand (~500-5,000 tokens)
- **MCP schemas:** Deferred by Tool Search — loaded only when needed

You get 187 skills available for **less context cost than a single long prompt**.

---

## Staying Updated

Rising Tides includes a built-in update command:

```bash
update-rising-tides
```

This checks for new skills, downloads updates, and shows what changed.

---

## Uninstall

### Remove Skills Only (Keep Claude Code)

Removes Rising Tides content but keeps Claude Code and all prerequisites intact.

**Mac/Linux:**
```bash
gh repo clone SunsetSystemsAI/rising-tides-starter-pack /tmp/rising-tides
bash "/tmp/rising-tides/New user starter pack/scripts/uninstall-skills.sh"
```

**Windows:**
```powershell
gh repo clone SunsetSystemsAI/rising-tides-starter-pack "$env:TEMP\rising-tides"
& "$env:TEMP\rising-tides\New user starter pack\scripts\uninstall-skills.ps1"
```

### Full Uninstall (Remove Everything)

> **Warning:** This removes Claude Code, all configuration, and Rising Tides content. Cannot be undone.

**Mac/Linux:**
```bash
gh repo clone SunsetSystemsAI/rising-tides-starter-pack /tmp/rising-tides
bash "/tmp/rising-tides/New user starter pack/scripts/uninstall-full.sh"
```

**Windows (as Administrator):**
```powershell
gh repo clone SunsetSystemsAI/rising-tides-starter-pack "$env:TEMP\rising-tides"
& "$env:TEMP\rising-tides\New user starter pack\scripts\uninstall-full.ps1"
```

---

## Troubleshooting

### The script says "command not found: node"
Node.js didn't install or isn't in your PATH. Close your terminal, reopen it, and try again. If that doesn't work, install Node.js manually from https://nodejs.org.

### The script says "command not found: claude"
Claude Code didn't install correctly. Run the installer manually:
- **Mac/Linux:** `curl -fsSL https://claude.ai/install.sh | bash -s latest`
- **Windows:** `irm https://claude.ai/install.ps1 | iex`

### Skills aren't loading in Claude Code
1. Make sure you restarted Claude Code after setup
2. Check skills exist: `ls ~/.claude/skills | head`
3. Check Tool Search is enabled: `echo $ENABLE_TOOL_SEARCH` (should show `true`)

### GitHub authentication issues
Run `gh auth logout` then `gh auth login` to re-authenticate.

### Need to run setup again?
The script is safe to run multiple times. It skips anything already installed.

---

## Security

Every skill, script, and configuration file in Rising Tides has been security audited.

| Metric | Result |
|--------|--------|
| Files Scanned | 1,100+ |
| Critical Issues | 0 |
| High Issues | 0 |
| Community Repos Audited | 16 |

The setup scripts only:
- Install well-known tools from official sources (Homebrew, NodeSource, winget, npm)
- Copy files to `~/.claude/` — nothing is modified outside that directory
- Clean up temporary files when done

---

## Support

- **Community:** [Rising Tides on Skool](https://www.skool.com/rising-tides-9034)
- **Issues:** [GitHub Issues](https://github.com/SunsetSystemsAI/setup/issues)
- **Email:** nick@sunsetsystems.co

---

## Attribution

Rising Tides curates skills from the open-source community. All credit to the original authors:

| Source | Skills | License |
|--------|--------|---------|
| [Trail of Bits](https://github.com/trailofbits/skills) | 24 | Apache-2.0 |
| [Corey Haines](https://github.com/coreyhaines31/marketingskills) | 23 | MIT |
| [Jeff Allan](https://github.com/Jeffallan/claude-skills) | 60+ | MIT |
| [Softaworks](https://github.com/softaworks/agent-toolkit) | 40 | MIT |
| [harperaa](https://github.com/harperaa/secure-claude-skills) | 11 | MIT |
| And more... | | |

---

<div align="center">

**A Rising Tide Lifts All Boats**

MIT License. Individual skills retain their original licenses.

</div>
