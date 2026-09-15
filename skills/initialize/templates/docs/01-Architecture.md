# Architecture

How <name> is built. What the product **is** lives in `docs/00-Product.md`;
the vocabulary in `docs/03-Domain.md`; the reason behind each decision in
`docs/adr/`. The architecture itself is FOCUS (`docs/manuals/focus.md`);
this document says how FOCUS lands in this codebase.

---

## 1. The design in one sentence

<!-- init: one sentence. "A React PWA talks directly to Postgres through
     RLS and RPC" or "An ASP.NET API in vertical slices, MediatR handlers as
     orchestrators, EF Core repositories, a Blazor front end". -->

## 2. Stack

```
<!-- init: a block like this, one line per concern:
Language    C# 13 · .NET 9
API         ASP.NET Core minimal API · MediatR 12 (orchestrators)
Data        PostgreSQL 16 · EF Core 9 · migrations in src/Migrations
Front end   ...
Tests       xUnit · FluentAssertions · Testcontainers
Tooling     dotnet format · <linter> · <CI>
-->
```

**Out, by decision** (they come in only by demonstrated need, and the
delivery that introduces one justifies it):

<!-- init: the libraries, layers and tools this project does not use. Name
     them, so the next session does not add them "to be safe". -->

## 3. The four pieces in this codebase

| Piece | Here it is | Lives in |
|---|---|---|
| View | <!-- init: controller, endpoint, page, component --> | |
| Orchestrator | <!-- init: mediator request handler (MediatR or other), BLoC, store --> | |
| Use case | <!-- init: pure static method, record with a method --> | |
| Repository | <!-- init: EF Core class, HTTP client wrapper --> | |

<!-- init: then the rules that make the table checkable in this stack:
     what a Result type is called here; where the composition root is
     (Program.cs, main.ts); which interfaces exist and why (a second
     implementation, or a test fake). Brownfield: if the code is organized by
     layer, say so here, say what the target layout is, and point at the
     migration deliveries in docs/06-Queue.md. -->

## 4. A slice

```
<!-- init: the folder layout of one feature, as it exists or as it should:
src/Features/Orders/PlaceOrder/
├── PlaceOrderEndpoint.cs      view
├── PlaceOrderHandler.cs       orchestrator (MediatR)
├── PlaceOrder.cs              use case, pure
├── PlaceOrderRequest.cs       command
└── PlaceOrderTests.cs         the use case's unit tests
src/Features/Orders/OrdersRepository.cs   shared by the slices of Orders
-->
```

<!-- init: what is shared across slices (the repository per aggregate,
     the Result type, the composition root) and what is never shared
     (a use case, a handler, a view model). The signal, not the rule: a
     simple slice fits in four or five files; ten deserves the question
     "what became a layer again?". -->

## 5. Data access and boundaries

<!-- init: table: situation → how. Own data CRUD, cross-boundary reads,
     transactions, external calls, caches. Where privacy or authorization
     is enforced, and why there (the server, never the client). -->

## 6. Errors are values

<!-- init: what the Result type is in this stack, where exceptions are
     born (only in repositories), how the view renders each case, what
     the framework's own error mechanism is allowed to handle. -->

## 7. Environments

| Environment | Where | How code gets there | Used for |
|---|---|---|---|
| <!-- init: local / dev / staging / production --> | | | |

<!-- init: which environment is the truth while building; which one a
     delivery must leave up to date; which one is production and what
     changes in behaviour because of it. Details in docs/05-Process.md
     §Environments; this section is the map, that one is the rule. -->

## 8. What is not rebuilt

<!-- init: what was tried, cost, and was removed on purpose, so that no
     session brings it back with good intentions. Greenfield: start with
     the FOCUS anti-patterns list in docs/manuals/focus.md and add nothing
     until something is actually removed. -->
