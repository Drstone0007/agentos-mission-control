<div align="center">

# ⬡ AgentOS Mission Control

### The glass cockpit for your AI agent fleet

**Python stdlib only. Zero npm. Zero pip. One command to launch.**

[![Python 3.11+](https://img.shields.io/badge/python-3.11+-blue.svg)](https://python.org)
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![Glassmorphism](https://img.shields.io/badge/UI-Glassmorphism-8B5CF6.svg)](#design-system)
[![Three.js](https://img.shields.io/badge/Background-Three.js-7DD3FC.svg)](#threejs-particles)

```
 ┌─────────────────────────────────────────────────────────────────────┐
 │  ◉ HERMES  / ORCHESTRATOR  v1.0          Overview · Agents · Tasks │
 │                              All systems operational    14:32:07   │
 ├─────────────────────────────────────────────────────────────────────┤
 │                                                                     │
 │    ╭──────╮    CURRENT DIRECTIVE         VPS HEALTH                │
 │    │ ◎ ◎  │    CODR · built dashboard    CPU  ████████░░ 39.5%    │
 │    │  ◉   │    backend and frontend      RAM  ██████░░░░ 58.2%    │
 │    │ ● ●  │                               DISK ████░░░░░░ 41.0%   │
 │    ╰──────╯    CONTEXT WINDOW                                     │
 │               ORCH ████████░░ 8        HERMES DBs  2.4 KB         │
 │               ANAL ██████░░░░ 6                                    │
 │               WRTR █████░░░░░ 5        QUEUE  11  ERRORS  1        │
 │               MRKT ████░░░░░ 4        TODAY  3   UPTIME  14d      │
 │               CODR ████████░░ 8                                    │
 │ ────────────────────────────────────────────────────────────────── │
 │  INTEGRITY  AGENT CALLS   MESSAGES    TOKENS IN    CACHE HITS     │
 │    91%        11            48         12,847        3,291         │
 │  ▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓   ▓▓▓▓▓▓▓▓▓▓  │
 └─────────────────────────────────────────────────────────────────────┘
```

---

</div>

## What is this?

A **read-only mission control dashboard** for the [Hermes AgentOS](https://github.com/Drstone0007/manus-os) multi-agent system. One Python server, one HTML file, five tabs of live operational intelligence.

You build it once. You stare at it forever.

---

## ✦ Design Language

This isn't a Bootstrap dashboard. It's a **glass cockpit** — the same design philosophy used in fighter jet HUDs and sci-fi command centers, translated to web.

### Glassmorphism

Every card floats on a bed of `backdrop-filter: blur(20px) saturate(1.4)` — translucent glass panels that let the Three.js particle field breathe through. Inner light gradients simulate light refraction. Hover any card and the border brightens while the shadow deepens.

```
 ╭──────────────────────────────────╮
 │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│ ← inner light gradient
 │  ░  ╭──────────────────────╮  ░  │
 │  ░  │  translucent glass    │  ░  │ ← backdrop-filter: blur(20px)
 │  ░  │  particles visible    │  ░  │
 │  ░  │  through the panel    │  ░  │
 │  ░  ╰──────────────────────╯  ░  │
 │░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░│ ← colored glow shadow
 ╰──────────────────────────────────╯
```

### Three.js Particle Field

800 floating particles in violet, cyan, mint, pink, and magenta — additive-blended with shader materials. Mouse parallax moves the camera. 20 drifting lines create depth. The background isn't decoration; it's the atmosphere.

```
    ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
  ·     ·  ·  ·  ·  ·  ·  ·  ·
·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
  ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
    ·  ·  ·  ·  ·  ·  ·  ·  ·  ·
```

### Dissolve / Vanish Transitions

Tab switches don't just swap — they **dissolve out** (blur + shrink + fade) then **dissolve in** (unblur + grow + fade). Cards stagger-animate with 80ms delays. Every interaction feels intentional.

```
  ┌─────────┐         ┌─────────┐         ┌─────────┐
  │  TAB A  │ ──blur──│  EMPTY  │──unblur──│  TAB B  │
  │  visible│  +scale │  frame  │  +scale  │ visible │
  └─────────┘  +fade  └─────────┘  +fade   └─────────┘
    vanishOut            350ms           dissolveIn
```

### Scan Line

A violet gradient line sweeps down the ops console and log table — a subtle CRT echo that makes static data feel alive.

---

## ✦ What's Inside

### Five Tabs

| Tab | What You See | Data Source |
|-----|-------------|-------------|
| **Overview** | Ops console, agent radar, VPS health gauges, stats strip, throughput sparkline, activity feed | SSE + SQLite |
| **Agents** | Agent cards with activity charts, success rates, load bars, searchable log table, donut distribution | SQLite |
| **Tasks** | Personal operator board — drag-free status columns, inline editing, priority chips | board.db (R/W) |
| **Schedule** | Every cron job — Hermes and system — with plain-English descriptions | /etc/cron.d |
| **Content** | Document library — agent-grouped sidebar, markdown preview, live editor | /root/.hermes/content/ |

### Backend (server.py)

Python **stdlib only** — no pip packages, no npm, no node.

- `ThreadingHTTPServer` on `127.0.0.1:51763`
- Read-only SQLite connections (`file:path?mode=ro` + `PRAGMA query_only=1`)
- SSE event stream updating every 5 seconds
- VPS health from `/proc/stat`, `/proc/meminfo`, `os.statvfs`
- Cron parser with plain-English schedule descriptions
- Personal task board with full CRUD

### Frontend (index.html + tokens.css + components.js)

- **60+ CSS custom properties** — every color, spacing, radius, and animation is a token
- **Reusable component primitives** — GlassCard, Badge, StatCard, ProgressBar, ThinBar, DonutChart
- **Three.js shader materials** — custom vertex/fragment shaders for particle rendering
- **marked.js** — live markdown preview in the Content tab
- **Responsive** — collapses gracefully at 1024px

---

## ✦ Why This > Everything Else

| Feature | AgentOS Mission Control | Grafana | Datadog | Custom React Dashboard |
|---------|:----------------------:|:-------:|:-------:|:----------------------:|
| **Zero dependencies** | ✅ Python stdlib only | ❌ Node/Docker | ❌ Agent install | ❌ npm/webpack/babel |
| **Launch command** | `bash start.sh` | Docker compose | Agent + config | `npm run dev` |
| **Glassmorphism UI** | ✅ Native CSS | ❌ | ❌ | ⚠️ Libraries needed |
| **Three.js particles** | ✅ Built-in | ❌ | ❌ | ⚠️ Custom integration |
| **Dissolve animations** | ✅ CSS keyframes | ❌ | ❌ | ⚠️ Framer Motion etc |
| **Read-only to source DB** | ✅ `mode=ro` enforced | ⚠️ Config | ⚠️ Config | ⚠️ Custom |
| **Personal task board** | ✅ Built-in CRUD | ❌ | ❌ | ⚠️ Build yourself |
| **Content preview** | ✅ Markdown + editor | ❌ | ❌ | ⚠️ Build yourself |
| **Setup time** | 0 minutes | Hours | Hours | Days/weeks |
| **Cost** | $0 (VPS only) | $0-$2K/mo | $23+/host/mo | Dev time |
| **SSE live feed** | ✅ 5s updates | ✅ | ✅ | ⚠️ WebSockets |

**Bottom line:** Grafana and Datadog are monitoring platforms. This is a **command center** — purpose-built for one agent system, with the right data at the right granularity, running on zero infrastructure.

---

## ✦ Quick Start

### Prerequisites

- Python 3.11+
- Hermes AgentOS installed (`~/.hermes/`)

### Launch

```bash
git clone https://github.com/Drstone0007/agentos-mission-control.git
cd agentos-mission-control
bash start.sh
```

Dashboard: **http://127.0.0.1:51763**

### Remote Access

```bash
# SSH tunnel from your local machine
ssh -L 51763:127.0.0.1:51763 root@your-vps

# Then open http://localhost:51763
```

---

## ✦ Project Structure

```
agentos-mission-control/
├── index.html          # Full dashboard UI (5 tabs, Three.js, glassmorphism)
├── server.py           # Python stdlib backend (SSE, SQLite, CRUD)
├── tokens.css          # Design token system (60+ CSS custom properties)
├── components.js       # Reusable primitives (GlassCard, Badge, StatCard...)
├── start.sh            # One-command launcher
├── backup.sh           # Snapshot protocol (run before any frontend edit)
├── backups/            # Versioned file snapshots
├── board.db            # Personal task board (auto-created, read-write)
└── .gitignore
```

### Hermes Data (read-only)

```
~/.hermes/
├── agent-logs.db       # Activity logging database
├── state.db            # Session and token usage
├── kanban.db           # Hermes internal task board
├── gateway_state.json  # Live gateway status
├── content/            # Agent document storage
│   ├── orchestrator/
│   ├── analyst/
│   ├── writer/
│   ├── marketer/
│   └── coder/
└── agents/_shared/
    ├── log-task-local.sh   # Activity logging script
    └── cleanup-logs.sh     # Monthly retention cleanup
```

---

## ✦ Activity Logging

Every agent action is logged to SQLite with timestamp, model, and status.

```bash
# Log a task
bash ~/.hermes/agents/_shared/log-task-local.sh "coder" "built dashboard" "completed"

# Check recent logs
python3 -c "import sqlite3; [print(r) for r in sqlite3.connect('$HOME/.hermes/agent-logs.db').execute('SELECT agent_name, task_description, status FROM agent_logs ORDER BY created_at DESC LIMIT 5').fetchall()]"
```

### Monthly Cleanup

```bash
# Deletes rows older than 30 days, VACUUMs
bash ~/.hermes/agents/_shared/cleanup-logs.sh
```

---

## ✦ Design Token Reference

All visual decisions live in `tokens.css`. Never use raw hex, pixel values, or font names in component code.

| Token | Value | Usage |
|-------|-------|-------|
| `--bg-base` | `#15151F` | Page background |
| `--bg-glass` | `rgba(31,31,43,0.55)` | Card backgrounds |
| `--brand-violet` | `#8B5CF6` | Primary accent |
| `--brand-cyan` | `#7DD3FC` | Data highlights |
| `--brand-mint` | `#5EE2B5` | Success / active |
| `--brand-gold` | `#FBBF24` | Tokens / warnings |
| `--font-display` | `Inter Tight` | Headings / numbers |
| `--font-mono` | `JetBrains Mono` | Labels / code |
| `--blur-heavy` | `blur(16px)` | Glass effect |

### Agent Colors

| Agent | Color | Hex |
|-------|-------|-----|
| Orchestrator | Violet Glow | `#A78BFA` |
| Analyst | Cyan | `#7DD3FC` |
| Writer | Pink | `#F472B6` |
| Marketer | Magenta | `#E879F9` |
| Coder | Teal | `#2DD4BF` |

---

## ✦ Backup Protocol

**Before every frontend change**, snapshot the files:

```bash
bash backup.sh
# Backed up: index_v1.0_2026-06-22T09-38.html, server_v1.0_2026-06-22T09-38.py
```

If a build breaks, restore from `backups/` and identify which change caused it.

---

## ✦ Configuration

### Port

Change in `server.py` line 483:

```python
server = ThreadingHTTPServer(("127.0.0.1", 51763), DashboardHandler)
```

### Hermes Home

Default: `~/.hermes/`. Override with:

```bash
export HERMES_HOME=/path/to/.hermes
```

### Content Directory

Documents live at `$HERMES_HOME/content/{agent}/`. The Content tab reads these directly.

---

## ✦ Tech Stack

```
 ┌─────────────────────────────────────────┐
 │           AgentOS Mission Control        │
 ├─────────────┬─────────────┬─────────────┤
 │   Python    │   HTML/CSS  │  Three.js   │
 │   stdlib    │   Vanilla   │  r128       │
 ├─────────────┼─────────────┼─────────────┤
 │ SQLite3     │ Web APIs    │ GLSL        │
 │ /proc/*     │ SSE         │ Shaders     │
 │ os.statvfs  │ marked.js   │ Additive    │
 │ cron files  │ CSS Grid    │ Blending    │
 └─────────────┴─────────────┴─────────────┘
       No npm. No pip. No Docker.
```

---

## ✦ License

MIT — use it, fork it, ship it.

---

<div align="center">

**Built for operators who stare at dashboards all day and want the glass one.**

⬡

</div>
