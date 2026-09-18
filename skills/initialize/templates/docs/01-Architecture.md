# Architecture

How <name> is built. What the product **is** lives in `docs/00-Product.md`;
the vocabulary in `docs/03-Domain.md`; the reason behind each decision in
`docs/adr/`. §3 holds the four practices this project chose, and every other
section of this document follows from them.

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

## 3. The practices in this codebase

| Practice | Answer | Here it is |
|---|---|---|
| Structure | <!-- init: vertical slices, or by layer --> | <!-- init: the folder the answer produces --> |
| Rules | <!-- init: pure use cases behind an orchestrator, or where they sit today --> | <!-- init: the file or type a rule is written in --> |
| Errors | <!-- init: values, or exceptions as flow --> | <!-- init: the Result type, or what is thrown and where it is caught --> |
| Tests | <!-- init: a test per piece, or the project's own policy --> | <!-- init: docs/04-Conventions.md §5 --> |

<!-- init: the four answers are the ones the Practice questions of
     /initialize were given. Write the answer that was chosen, never the
     option list, and never an answer read off the code: the code is
     today's fact and this table is the decision. The header row above is
     the one row that is not translated; the Language section says why. -->

| Piece | Here it is | Lives in |
|---|---|---|
| View | <!-- init: controller, endpoint, page, component --> | |
| Orchestrator | <!-- init: mediator request handler (MediatR or other), BLoC, store --> | |
| Use case | <!-- init: pure static method, record with a method --> | |
| Repository | <!-- init: EF Core class, HTTP client wrapper --> | |

<!-- init: this second table holds the pieces the answers above give. A
     piece an answer removes keeps its row and reads "does not exist", with
     the reason in one line under the table: a Rules answer of "where they
     sit today" leaves no use case, and saying so is what keeps the next
     session from adding one for symmetry.
     Then the rules that make the table checkable in this stack: what a
     Result type is called here, when the errors answer is values; where the
     composition root is (Program.cs, main.ts); which interfaces exist and
     why (a second implementation, or a test fake). Brownfield, and only when
     the structure answer is vertical slices while the code is organized by
     layer: say so here, say what the target layout is, and point at the
     migration deliveries in docs/06-Queue.md. -->

## 4. A slice

```
<!-- init: when the structure answer of §3 is vertical slices, the folder
     layout of one feature, as it exists or as it should. When it is by
     layer, the layout of one change instead: the folders a single feature
     touches, in the order a request goes through them.
src/Features/Orders/PlaceOrder/
├── PlaceOrderEndpoint.cs      view
├── PlaceOrderHandler.cs       orchestrator (MediatR)
├── PlaceOrder.cs              use case, pure
├── PlaceOrderRequest.cs       command
└── PlaceOrderTests.cs         the use case's unit tests
src/Features/Orders/OrdersRepository.cs   shared by the slices of Orders
-->
```

<!-- init: what is shared (the repository per aggregate, the Result type
     when errors are values, the composition root) and what is never shared
     (a use case, a handler, a view model). Name only the pieces §3 gives.
     The signal, not the rule, and only when the structure answer is
     vertical slices: a simple slice fits in four or five files; ten
     deserves the question "what became a layer again?". -->

## 5. Data access and boundaries

<!-- init: table: situation → how. Own data CRUD, cross-boundary reads,
     transactions, external calls, caches. Where privacy or authorization
     is enforced, and why there (the server, never the client). -->

## 6. Errors are values

<!-- init: when the errors answer of §3 is values, what the Result type is
     in this stack, where exceptions are born (only in repositories), how
     the view renders each case, what the framework's own error mechanism
     is allowed to handle. When it is exceptions as flow, the same four
     questions about exceptions: which ones are flow, where they are
     thrown, where they are caught, what the framework handles. Either way
     the heading stays: a project that throws still says here how a failure
     reaches the person. -->

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
     session brings it back with good intentions. A piece §3 says does not
     exist belongs here too, with the reason it was never built.
     Greenfield, and only for the practices §3 answered the manual's way:
     start with the anti-patterns list of docs/manuals/focus.md §Anti-patterns
     and add nothing until something is actually removed. -->
