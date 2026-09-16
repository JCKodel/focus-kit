# Graph Report - focus-kit  (2026-09-16)

## Corpus Check
- 50 files · ~44,326 words
- Verdict: corpus is large enough that graph structure adds value.

## Summary
- 328 nodes · 364 edges · 37 communities (30 shown, 7 thin omitted)
- Extraction: 99% EXTRACTED · 1% INFERRED · 0% AMBIGUOUS · INFERRED: 3 edges (avg confidence: 0.75)
- Token cost: 0 input · 0 output

## Graph Freshness
- Built from commit: `095d5402`
- Run `git rev-parse HEAD` and compare to check if the graph is stale.
- Run `graphify update .` after code changes (no API cost).

## Community Hubs (Navigation)
- Initialize Command and Templates
- Graphify Integration and Delivery Process
- FOCUS Architecture Reference
- Kit Ownership and Propose Command
- FOCUS Pieces and House Rules
- focus-kit CLI Script
- Initialize Steps
- DRY, YAGNI and Vertical Slices
- MCP Server Wiring
- Three Languages Rule
- Doctor Command
- Update Command
- Process
- Architecture
- The delivery process
- Product
- Architecture
- Backend
- Domain and ubiquitous language
- Conventions and tests
- Conventions and tests
- SKILL.md
- graphify in this repository
- focus-kit
- Queue
- ADR-NNNN: <title>
- Queue
- ADR-NNNN: <title>
- ADR-0001: bash 3.2 and python3, and no other dependency
- ADR-0002: Every file is kit-owned, project-owned, merged or appended once
- ADR-0003: FOCUS is what the kit teaches, not how the kit is built
- SKILL.md
- <Project name>
- SKILL.md
- Architecture decision records
- Architecture decision records
- 02-Backend.md

## God Nodes (most connected - your core abstractions)
1. `FOCUS working reference for coding agents` - 21 edges
2. `FOCUS: a working reference for coding agents` - 13 edges
3. `Process` - 12 edges
4. `Process` - 12 edges
5. `The delivery process` - 11 edges
6. `Step 2: write the documents` - 10 edges
7. `Product` - 10 edges
8. `Product` - 10 edges
9. `Architecture` - 9 edges
10. `Architecture` - 9 edges

## Surprising Connections (you probably didn't know these)
- `Graph is a map, not source of truth` --semantically_similar_to--> `Step 1 brownfield: read repository first`  [INFERRED] [semantically similar]
  manuals/graphify.md → skills/initialize/SKILL.md
- `CLAUDE.md template` --references--> `FOCUS working reference for coding agents`  [EXTRACTED]
  skills/initialize/templates/CLAUDE.md → manuals/focus.md
- `Step 2: write the documents` --references--> `docs/04-Conventions.md template`  [EXTRACTED]
  .claude/skills/initialize/SKILL.md → skills/initialize/templates/docs/04-Conventions.md
- `focus-kit README` --references--> `The delivery process manual`  [EXTRACTED]
  README.md → manuals/process.md
- `FOCUS architecture` --references--> `FOCUS working reference for coding agents`  [EXTRACTED]
  README.md → manuals/focus.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **The propose/apply delivery flow across queue, work file, and docs** — manuals_process_queue_concept, skills_propose_skill, skills_apply_skill, templates_docs_06_queue [EXTRACTED 0.90]
- **The four FOCUS pieces forming one unidirectional flow** — manuals_focus_view, manuals_focus_orchestrator, manuals_focus_use_case, manuals_focus_repository [EXTRACTED 0.95]
- **Brownfield initialization: read code, build graph, write docs** — skills_initialize_step1_brownfield, manuals_graphify_cli, skills_initialize_step2_write_documents [INFERRED 0.85]

## Communities (37 total, 7 thin omitted)

### Community 0 - "Initialize Command and Templates"
Cohesion: 0.15
Nodes (12): 0. Language, 10. What does not exist in this process, 1. The rule, 2. The flow, 3. The format of `work/<slug>.md`, 4. Verify, 5. Environments, 6. Proof (+4 more)

### Community 1 - "Graphify Integration and Delivery Process"
Cohesion: 0.13
Nodes (17): graphify in this repository manual, graphify CLI, Graph is a map, not source of truth, graphify MCP server, graphify-out/ directory, graphify post-commit hook, /graphify Claude Code skill, /apply command (+9 more)

### Community 2 - "FOCUS Architecture Reference"
Cohesion: 0.13
Nodes (27): FOCUS working reference for coding agents, FOCUS anti-patterns (ch.19), Book: FOCUS (Feature-Oriented, Clean, Unidirectional, Scalable), Composition Root and Constructor Injection, CQS / CQRS-lite, FOCUS orchestrator as Mediator pattern in C#, DRY (knowledge duplication), Errors are values (Result type) (+19 more)

### Community 3 - "Kit Ownership and Propose Command"
Cohesion: 0.17
Nodes (20): Step 2: write the documents, initialize skill, Step 0: kind of project and documentation language, Step 1 greenfield: ask in rounds, Step 3: CLAUDE.md merge, Step 4: report and queue next step, CLAUDE.md template, Contract section (must be exact) (+12 more)

### Community 4 - "FOCUS Pieces and House Rules"
Cohesion: 0.11
Nodes (17): 10. Anti-patterns (ch. 19), 11. Legacy code and daily routine (chs. 20 and 23), 12. Sources the book names, 1. What FOCUS is, 2. The canonical responsibility table (verbatim, docs/tabela-canonica-en.md), 3. The four pieces, 4. The orchestrator's recipe, 5. Errors are values (ch. 8) (+9 more)

### Community 5 - "focus-kit CLI Script"
Cohesion: 0.45
Nodes (12): focus-kit script, copy_tree(), die(), doctor(), ensure_graphify(), ensure_uv(), install_repo(), merge_json() (+4 more)

### Community 6 - "Initialize Steps"
Cohesion: 0.12
Nodes (16): A delivery, Domain and ubiquitous language, Entities and invariants, FOCUS, Language, Language of the interface, Ownership, Purpose (+8 more)

### Community 7 - "DRY, YAGNI and Vertical Slices"
Cohesion: 0.12
Nodes (15): Audience, Building it, Defining a delivery, Initializing, Installing, Keeping the map, Mechanics, Non-goals (+7 more)

### Community 12 - "Process"
Cohesion: 0.15
Nodes (12): 0. Language, 10. What does not exist in this process, 1. The rule, 2. The flow, 3. The format of `work/<slug>.md`, 4. Verify, 5. Environments, 6. Proof (+4 more)

### Community 13 - "Architecture"
Cohesion: 0.17
Nodes (11): 1. The design in one sentence, 2. Stack, 3. The four pieces in this codebase, 4. The layout, 5. Data access and boundaries, 6. Errors are values, 7. Environments, 8. What is not rebuilt (+3 more)

### Community 14 - "The delivery process"
Cohesion: 0.17
Nodes (11): 10. Updating the kit, 1. The idea in one paragraph, 2. The files, 3. `/initialize`, 4. `/propose <slug>`, 5. `/apply <slug>`, 6. The house rules, 7. The queue (+3 more)

### Community 15 - "Product"
Cohesion: 0.18
Nodes (10): Audience, Mechanics, Non-goals, Open decisions, Positioning, Product, Product questions, Purpose (+2 more)

### Community 16 - "Architecture"
Cohesion: 0.20
Nodes (9): 1. The design in one sentence, 2. Stack, 3. The four pieces in this codebase, 4. A slice, 5. Data access and boundaries, 6. Errors are values, 7. Environments, 8. What is not rebuilt (+1 more)

### Community 17 - "Backend"
Cohesion: 0.22
Nodes (8): 1. Topology, 2. Operation, 3. Environments and access, 4. Migration convention, 5. Authorization and privacy boundary, 6. Data, 7. Observability, Backend

### Community 18 - "Domain and ubiquitous language"
Cohesion: 0.22
Nodes (8): <Aggregate>, Domain and ubiquitous language, Entities and invariants, Language of the interface, Purpose, Related documents, Term in code, What is a fact and what is a preference

### Community 19 - "Conventions and tests"
Cohesion: 0.22
Nodes (8): 1. Language, 2. Names, 3. Style, 4. Errors are values, 5. Where things are tested, 6. Commits, Conventions and tests, Text a user reads

### Community 20 - "Conventions and tests"
Cohesion: 0.22
Nodes (8): 1. Language, 2. Names, 3. Style, 4. Errors are values, 5. Where things are tested, 6. Commits, Conventions and tests, Text a user reads

### Community 21 - "SKILL.md"
Cohesion: 0.25
Nodes (7): Language, Step 0: which kind of project, and in which language, Step 1 (brownfield): read the repository before asking anything, Step 1 (greenfield): ask in rounds, Step 3: CLAUDE.md, Step 4: report, Two house rules that shape everything you write

### Community 22 - "graphify in this repository"
Cohesion: 0.25
Nodes (7): Everyday use, graphify in this repository, Rules, The pieces, Troubleshooting, When the graph is rebuilt, Why it is here

### Community 23 - "focus-kit"
Cohesion: 0.33
Nodes (5): focus-kit, How to work, Layout, Non-negotiables, Read before acting

### Community 24 - "Queue"
Cohesion: 0.33
Nodes (5): Later, not scheduled, Milestone 1: <name>, Milestone 2: <name>, Open decisions, Queue

### Community 25 - "ADR-NNNN: <title>"
Cohesion: 0.33
Nodes (5): ADR-NNNN: <title>, Alternatives considered, Consequences, Context, Decision

### Community 26 - "Queue"
Cohesion: 0.33
Nodes (5): Later, not scheduled, Milestone 1: the kit checks itself, Milestone 2: the kit used on something real, Open decisions, Queue

### Community 27 - "ADR-NNNN: <title>"
Cohesion: 0.33
Nodes (5): ADR-NNNN: <title>, Alternatives considered, Consequences, Context, Decision

### Community 28 - "ADR-0001: bash 3.2 and python3, and no other dependency"
Cohesion: 0.33
Nodes (5): ADR-0001: bash 3.2 and python3, and no other dependency, Alternatives considered, Consequences, Context, Decision

### Community 29 - "ADR-0002: Every file is kit-owned, project-owned, merged or appended once"
Cohesion: 0.33
Nodes (5): ADR-0002: Every file is kit-owned, project-owned, merged or appended once, Alternatives considered, Consequences, Context, Decision

### Community 30 - "ADR-0003: FOCUS is what the kit teaches, not how the kit is built"
Cohesion: 0.33
Nodes (5): ADR-0003: FOCUS is what the kit teaches, not how the kit is built, Alternatives considered, Consequences, Context, Decision

### Community 31 - "SKILL.md"
Cohesion: 0.40
Nodes (4): Build, Close, Prove, Read first

### Community 32 - "<Project name>"
Cohesion: 0.40
Nodes (4): How to work, Non-negotiables, <Project name>, Read before acting

### Community 33 - "SKILL.md"
Cohesion: 0.40
Nodes (4): Never, Read first, Talk until it fits, Write

## Knowledge Gaps
- **204 isolated node(s):** `Read first`, `Build`, `Prove`, `Close`, `Language` (+199 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **7 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `FOCUS working reference for coding agents` connect `FOCUS Architecture Reference` to `Graphify Integration and Delivery Process`, `Kit Ownership and Propose Command`?**
  _High betweenness centrality (0.021) - this node is a cross-community bridge._
- **Why does `Step 2: write the documents` connect `Kit Ownership and Propose Command` to `SKILL.md`?**
  _High betweenness centrality (0.012) - this node is a cross-community bridge._
- **Why does `initialize skill` connect `Kit Ownership and Propose Command` to `Graphify Integration and Delivery Process`, `FOCUS Architecture Reference`?**
  _High betweenness centrality (0.011) - this node is a cross-community bridge._
- **What connects `Read first`, `Build`, `Prove` to the rest of the system?**
  _209 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Graphify Integration and Delivery Process` be split into smaller, more focused modules?**
  _Cohesion score 0.1323529411764706 - nodes in this community are weakly interconnected._
- **Should `FOCUS Architecture Reference` be split into smaller, more focused modules?**
  _Cohesion score 0.12535612535612536 - nodes in this community are weakly interconnected._
- **Should `FOCUS Pieces and House Rules` be split into smaller, more focused modules?**
  _Cohesion score 0.1111111111111111 - nodes in this community are weakly interconnected._