# Graph Report - /Volumes/Data/Projects/focus-kit  (2026-09-16)

## Corpus Check
- Corpus is ~30,867 words - fits in a single context window. You may not need a graph.

## Summary
- 134 nodes · 257 edges · 12 communities (8 shown, 4 thin omitted)
- Extraction: 96% EXTRACTED · 4% INFERRED · 0% AMBIGUOUS · INFERRED: 9 edges (avg confidence: 0.74)
- Token cost: 187,743 input · 0 output

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

## God Nodes (most connected - your core abstractions)
1. `FOCUS working reference for coding agents` - 21 edges
2. `/initialize skill` - 16 edges
3. `FOCUS architecture` - 12 edges
4. `01-Architecture.md template` - 12 edges
5. `05-Process.md template` - 11 edges
6. `CLAUDE.md template` - 10 edges
7. `00-Product.md template` - 10 edges
8. `The delivery process manual` - 9 edges
9. `Orchestrator layer` - 9 edges
10. `Step 2: write the documents` - 9 edges

## Surprising Connections (you probably didn't know these)
- `Never end silent about environments` --semantically_similar_to--> `The delivery process`  [INFERRED] [semantically similar]
  .claude/skills/apply/SKILL.md → docs/manuals/process.md
- `Graph is a map, not source of truth` --semantically_similar_to--> `Step 1 brownfield: read repository first`  [INFERRED] [semantically similar]
  manuals/graphify.md → skills/initialize/SKILL.md
- `One-page delivery rule` --semantically_similar_to--> `House rules`  [INFERRED] [semantically similar]
  .claude/skills/initialize/templates/docs/05-Process.md → docs/manuals/process.md
- `What the process deliberately lacks` --semantically_similar_to--> `FOCUS anti-patterns (ch.19)`  [INFERRED] [semantically similar]
  manuals/process.md → manuals/focus.md
- `CLAUDE.md template` --references--> `FOCUS working reference for coding agents`  [EXTRACTED]
  skills/initialize/templates/CLAUDE.md → manuals/focus.md

## Import Cycles
- None detected.

## Hyperedges (group relationships)
- **The propose/apply delivery flow across queue, work file, and docs** — manuals_process_queue_concept, skills_propose_skill, skills_apply_skill, templates_docs_06_queue [EXTRACTED 0.90]
- **The four FOCUS pieces forming one unidirectional flow** — manuals_focus_view, manuals_focus_orchestrator, manuals_focus_use_case, manuals_focus_repository [EXTRACTED 0.95]
- **Brownfield initialization: read code, build graph, write docs** — skills_initialize_step1_brownfield, manuals_graphify_cli, skills_initialize_step2_write_documents [INFERRED 0.85]
- **The delivery lifecycle across initialize, propose and apply** — claude_skills_initialize_skill, claude_skills_propose_skill, claude_skills_apply_skill, docs_manuals_process_queue [EXTRACTED 0.90]
- **FOCUS four-piece unidirectional flow** — docs_manuals_focus_view, docs_manuals_focus_orchestrator, docs_manuals_focus_use_case, docs_manuals_focus_repository [EXTRACTED 0.95]
- **The docs/00-06 template set written in order by /initialize** — claude_skills_initialize_templates_docs_03_domain, claude_skills_initialize_templates_docs_00_product, claude_skills_initialize_templates_docs_01_architecture, claude_skills_initialize_templates_docs_02_backend, claude_skills_initialize_templates_docs_04_conventions, claude_skills_initialize_templates_docs_05_process, claude_skills_initialize_templates_docs_06_queue [EXTRACTED 0.85]

## Communities (12 total, 4 thin omitted)

### Community 0 - "Initialize Command and Templates"
Cohesion: 0.16
Nodes (31): Never end silent about environments, /apply skill, Brownfield initialize flow, Greenfield initialize flow, Three languages kept apart, /initialize skill, CLAUDE.md template, 00-Product.md template (+23 more)

### Community 1 - "Graphify Integration and Delivery Process"
Cohesion: 0.10
Nodes (24): graphify in this repository manual, graphify CLI, Graph is a map, not source of truth, graphify MCP server, graphify-out/ directory, graphify post-commit hook, /graphify Claude Code skill, The delivery process manual (+16 more)

### Community 2 - "FOCUS Architecture Reference"
Cohesion: 0.18
Nodes (20): FOCUS working reference for coding agents, FOCUS anti-patterns (ch.19), Book: FOCUS (Feature-Oriented, Clean, Unidirectional, Scalable), Composition Root and Constructor Injection, CQS / CQRS-lite, FOCUS orchestrator as Mediator pattern in C#, DRY (knowledge duplication), Errors are values (Result type) (+12 more)

### Community 3 - "Kit Ownership and Propose Command"
Cohesion: 0.21
Nodes (17): focus-kit (kit CLAUDE.md), Kit-owned vs project-owned files, No em dash rule, Step 2: write the documents, Contract section (must be exact), propose never writes code, propose skill, docs/00-Product.md template (+9 more)

### Community 4 - "FOCUS Pieces and House Rules"
Cohesion: 0.24
Nodes (14): One-page delivery rule, FOCUS anti-patterns (ch.19), Composition Root / DI, CQS / CQRS-lite, Errors are values, Mediator pattern as orchestrator (C#), Orchestrator (FOCUS piece), Repository (FOCUS piece) (+6 more)

### Community 5 - "focus-kit CLI Script"
Cohesion: 0.45
Nodes (12): focus-kit script, copy_tree(), die(), doctor(), ensure_graphify(), ensure_uv(), install_repo(), merge_json() (+4 more)

### Community 6 - "Initialize Steps"
Cohesion: 0.33
Nodes (6): initialize skill, Step 0: kind of project and documentation language, Step 1 greenfield: ask in rounds, Step 3: CLAUDE.md merge, Step 4: report and queue next step, CLAUDE.md template

### Community 7 - "DRY, YAGNI and Vertical Slices"
Cohesion: 0.67
Nodes (3): DRY (knowledge, not text), Vertical slices / folder layout, YAGNI and KISS

## Knowledge Gaps
- **28 isolated node(s):** `graphify-mcp`, `/initialize command`, `/propose command`, `/apply command`, `focus-kit install command` (+23 more)
  These have ≤1 connection - possible missing edges or undocumented components.
- **4 thin communities (<3 nodes) omitted from report** — run `graphify query` to explore isolated nodes.

## Suggested Questions
_Questions this graph is uniquely positioned to answer:_

- **Why does `FOCUS working reference for coding agents` connect `FOCUS Architecture Reference` to `Graphify Integration and Delivery Process`, `Kit Ownership and Propose Command`, `Initialize Steps`?**
  _High betweenness centrality (0.147) - this node is a cross-community bridge._
- **Why does `docs/05-Process.md template` connect `Kit Ownership and Propose Command` to `Graphify Integration and Delivery Process`?**
  _High betweenness centrality (0.122) - this node is a cross-community bridge._
- **Why does `focus-kit (kit CLAUDE.md)` connect `Kit Ownership and Propose Command` to `focus-kit CLI Script`?**
  _High betweenness centrality (0.112) - this node is a cross-community bridge._
- **What connects `graphify-mcp`, `No em dash rule`, `Kit-owned vs project-owned files` to the rest of the system?**
  _42 weakly-connected nodes found - possible documentation gaps or missing edges._
- **Should `Graphify Integration and Delivery Process` be split into smaller, more focused modules?**
  _Cohesion score 0.10144927536231885 - nodes in this community are weakly interconnected._