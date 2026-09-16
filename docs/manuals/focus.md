<!-- kit-owned: focus-kit update overwrites this file. Edit it in the focus-kit repository, not here. -->

# FOCUS: a working reference for coding agents

Condensed from *FOCUS* (Feature-Oriented, Clean, Unidirectional, Scalable), English edition, chapters 04 to 23. Quotes are the book's own words. Anything not stated by the book is marked "(inference)".

## 1. What FOCUS is

FOCUS is a four-piece architecture with flow in one direction only: the View fires events and draws the state it receives; the Orchestrator receives the event, fetches data, calls the rule, and publishes the next state; Use Cases are the only place for business rules, pure functions that take data and return a Result; Repositories fetch and save, and they are the boundary where an exception exists and turns into a value exactly once (ch. 23). Code is organized by feature, not by layer, so a change request opens one folder. The single criterion that decides whether a layer exists is stated in chapter 10: "**every layer pays its own way**. A layer only earns its place if it can point at a verifiable gain that would vanish without it, and 'organization' and 'best practices' aren't verifiable gains." The book's own accounting: the View pays because it can be swapped whole without a rule line changing; the orchestrator pays because it "creates a single spot where the screen's state is born"; the use case pays because "it's testable with zero infrastructure"; the repository pays because it "concentrates in one file the only place in the program where an exception can be born." A fifth layer (a DTO mapper between use case and repository) is rejected by the same test: the translation is real, but "it belongs to the repository. This isn't a layer, it's a data transformation."

## 2. The canonical responsibility table (verbatim, docs/tabela-canonica-en.md)

| Layer | Does | Forbids |
|---|---|---|
| View | fires events | business rules |
| | renders state | data access |
| Orchestrator | converts event to state | deciding rules |
| | fetches data from the repository | persisting |
| | calls use cases | |
| | publishes state | |
| Use Case | the only place for business rules | IO |
| | is a pure function | framework |
| | takes data, returns a Result | domain exception |
| Repository | CRUD (fetch and save) | business rules |
| | the only place an infra exception becomes a Result | |

Why two columns: "The 'does' column is the promise; the 'forbids' column is what turns the promise into something a reviewer can point at on screen." "'This `if` decides whether the discount applies, and it sits in the orchestrator' is a checkable sentence. 'This code seems a bit coupled' isn't." (ch. 10)

## 3. The four pieces

### View (ch. 12)
- Does: "two verbs and no more: fire the event when something happens, and render the state when it arrives." Input is **renderable state**: "the total's text already formatted, the button enabled or disabled as a boolean, the list already sorted. Nothing to calculate. If it arrived, render it." Output is a business-named event (`AddItem`, `PayTab`) that carries the bare minimum: no total, no discount, no formatted text.
- Forbids: business rules, data access. Formatting, sorting, and comparing business values are decisions, and "no decision belongs to the screen." Local pure-UI state (focus, scroll, animation) may stay: "The test is asking whether Rosie cares."
- Contract: `TabData` in (ready strings and booleans), `TabEvent` out through one callback (`onEmit`).
- Review rules:
  1. The **wrong-layer test**: "if the screen compares business values in an `if`, that `if` is in the wrong layer." The test "fails on the operand, not the result" (`points >= 100 ? green : black` is a leak even though the result is a color).
  2. A `double total` or `priceInCents` field on the state invites the screen to format; renderable state carries `String formattedTotal`. "The field's type gives away who's deciding."
  3. `items.sort()`, `DateFormat(...)`, or currency formatting inside the render: leaked, the state arrives sorted and formatted.
  4. A repository call inside the screen ("just to show a counter" or in `initState`) punches through both bans at once; the screen fires a load event instead.
  5. Grep the screen file for `if (`, `+`, and `format`; every hit on a business value is a candidate to change address.

### Orchestrator (ch. 13)
- Does: "converts event to state", "fetches data from the repository", "calls use cases", "publishes state". "The Orchestrator knows *when* and *where to*. It never knows *what*." It is the BLoC, Cubit, ViewModel, Redux store, or MVI model of your ecosystem; the book keeps one name because "your ecosystem's name changes and the role doesn't."
- Forbids: deciding rules, persisting. "A cache is persistence with an expiration date, and the table's line forbids persisting, deadline or not." The repository may cache internally; the orchestrator may not hold data.
- Contract: one event in, one closed state out (`Loading | Ready(data) | Failed(message)`), published through a channel the screen subscribes to. Reactivity lives here: "the Orchestrator is the sole owner of the channel that carries state down to the View." One orchestrator per feature, not per screen.
- Review rules:
  1. **Connect vs. decide**: every line answers "when" or "where to" (connecting) or "what" (deciding). "If it answers 'what,' it's in the wrong place."
  2. "An `if` that compares a business value (item, price, quantity) is a decision, and decisions belong in the use case." `if (event.item.isEmpty) return;` at the top of a handler is the disguised version.
  3. Grep the orchestrator for `if (`, `>=`, and `[`: business-value comparisons go to a use case; "every write into a collection that survives past the method" goes to the repository.
  4. Formatting `1895` as "$18.95" or picking the generic error message is translating, not deciding, and may stay (extract a pure `formatCurrency` when it grows). The test: "if Rosie changes the business rule, does this `if` change?" If no, it can stay (ch. 19).
  5. "Never emit state from a cycle that's already been overtaken": process events serially.
  6. A switch over the use case's Result must be exhaustive; `Success` becomes `Ready`, `RuleViolated` becomes `Failed`, no case untranslated.

### Use Case (ch. 14)
- Does: "a business rule isolated as a named operation: a domain verb that takes the data it needs, applies the house policy, and returns the verdict." One verb per function, file named by the verb (`split_tab`, `apply_loyalty_discount`), never a ten-method "service" ("the junk drawer where ownerless rules pile up").
- Forbids: IO, framework, domain exception. "No `SELECT`, no widget, no `throw` to signal that the customer has no points."
- Contract: **signature as contract**. `DiscountResult applyLoyaltyDiscount(Tab tab, int loyaltyPoints)` takes data only, returns a typed Result with one variant per outcome (`DiscountApplied`, `NotEligibleForDiscount(points, pointsNeeded)`, `ItemOutOfStock(name)`). **Materialized data**: "everything the rule needs gets assembled BEFORE the call, by whoever called it, and handed over ready. Missing a piece of data? The input grows to carry it. The use case never goes looking for it."
- Review rules:
  1. "Open any use case or 'service' in your project and read only the signature, no body. If it takes a repository, an HTTP client, a clock, or a logger, the body has hidden IO and the test is going to ask for a double."
  2. `addItem(TabRepository repo, int table, Item item)` is "an orchestrator wearing a use-case costume" (ch. 10). The rule receives the tab already fetched.
  3. A refusal is a `return` of a Result variant, never a `throw`. "A customer without points is routine, not exceptional."
  4. No `try`, no `await`, no database `import` in the body.
  5. No single-implementation `IDiscountUseCase` interface: the pure function "receives no collaborator to swap", so "it simply has nothing to abstract."
  6. "If a rule needs a mock to be tested, it's in the wrong layer."

### Repository (ch. 15)
- Does: CRUD on demand, with the verbs the feature asks for (`findTab`, `save`, `markAsPaid`), returning distinct Results for read and write (`LookupResult`, `SaveResult`) with the infra failure shared (`InfraFailure(Failure.noConnection)`). It owns the translation between the persistence model and the domain model; "the persistence model belongs to the repository and dies inside it" (ch. 10). It may cache internally, invisibly.
- Forbids: business rules. "The repository knows *where* the data lives and *how* to talk to it. It never knows *whether* the customer earned the discount."
- Contract: per-feature interface, request/response, no generic `save<T>` or `getAll()`, no `watch` stream (reactivity is the orchestrator's). **Single exception translation**: "catching the infrastructure exception at the boundary, exactly once, with immediate conversion into a typed `Failure`; no other layer ever touches that exception again."
- Review rules:
  1. "Every infrastructure exception dies in the repository; if it showed up in another layer, you have a leak." A `try/catch` around a repository call in the orchestrator or use case: remove it, do not add one.
  2. Grep the repository for `if` and `where`/`filter`: "Every condition whose operand is a business value (loyalty points, a price range, 'earned it') is a rule that leaked into the query." Selection by table, status, date, page size stays: "The repository selects; it doesn't decide."
  3. `WHERE`, `ORDER BY`, and pagination belong in the query; pulling the whole table to filter in memory is the "`findAll` trap."
  4. A public `Repository<T>` with string filters is the generic repository anti-pattern; `<T>` is fine only as a private helper behind business verbs.
  5. `Failure` carries domain facts (`noConnection`, `timedOut`), never the driver's exception type: "a stable contract... changes when the rule changes, not when the database changes."
  6. Slice-wide grep (ch. 19): `grep -rn "import" features/ | grep -E "http|sql|dio|axios" | grep -v _repository` must come back empty.

## 4. The orchestrator's recipe

From chapter 10: the orchestrator "gathers the ingredients the use case is going to need, hands everything over at once, persists only what held up, and publishes one state, always just one. It never tastes the batter along the way."

1. `findTab(table)`: fetch from the repository; if the lookup returns `InfraFailure`, publish `Failed` and stop.
2. `addItem(tab, item, points)`: call the use case with materialized data; it "decides, no network, no database" and returns a Result.
3. `save(new tab)`: tell the repository to write what the use case approved. The write is the repository's; "the repository does the writing, and the orchestrator (chapter 13) tells it to" (ch. 16). The ban on "persisting" is a ban on the orchestrator holding or caching data itself.
4. Publish exactly one outcome state: `TabUpdated`, `InvalidItem`, or `InfraFailure`.

"Either it worked or it didn't, and both cases travel back through the same path, in the same type... There's no intermediate state sneaking out the side, no exception climbing outside the flow, and no second channel where the failure travels. One intent goes in, one Result comes out." Chapter 13's real orchestrator also emits `Loading` before the work starts; that is the book's own waiting state on the same channel, not a second outcome. "Four steps, zero decisions. The whole method survives any change to the coffee shop's rules without a single edited line."

## 5. Errors are values (ch. 8)

- The criterion: "is this failure part of the business flow? If it is, it becomes a return value, with its own type and its own data. If it isn't, it's a bug, and a bug should stay an exception." Declined card, dropped connection, insufficient points: values. Index out of range, null where null was impossible: exceptions, "crash early with a stack trace."
- **Result**: "a return type that carries either success or failure, one of the two, never both." A closed list (sealed class, union, enum) with one variant per outcome, each carrying exactly the data the screen needs, consumed by an exhaustive switch with no `default`. "If the failure shows up in the signature, it gets handled; if it doesn't, it gets forgotten."
- Where exceptions are born: "an infrastructure exception exists only at the infrastructure boundary, where it gets translated exactly once into a typed `Failure`; from there inward, only Results circulate through the app." "This is the only legitimate `try/catch` in Rosie's Coffee Shop app, and it lives in the repository."
- "Throw is not flow" (inference, the book's phrase is **invisible control flow**): a `throw` is "an execution path no signature declares." A use case that throws `NoPointsException` has "invisible control flow the caller can forget to catch." The boundary rule runs both ways: "an exception becomes a value on the way into the domain, and it doesn't turn back into an exception while it's still inside."
- Two pitfalls: the `_ =>` / `default` catch-all "swallows the cases you haven't handled yet" and kills exhaustiveness; and **Result hell**, re-wrapping on every layer, is answered by translating once: "that same `Failure` travels from the use case to the screen without changing clothes on every floor."
- Composition is Railway-Oriented Programming (Wlaschin): early `return` of the failing Result is the track switch; Rust's `?` is the same in one character.

## 6. Vertical slices, DRY, YAGNI, KISS, CQS

**Folder layout (ch. 11).** Organize by the **axis of change**: "things that change together should live together." One flat folder per feature, four role suffixes, no subfolders, the domain model as the bare name:

```text
features/tab/
  tab                (domain model: Tab, Item; no role suffix)
  tab_view           (View)
  tab_orchestrator   (Orchestrator)
  split_tab          (use case: a verb, one file per rule)
  tab_repository     (Repository; persistence model lives inside)
```

C#, Java, Kotlin, Swift, PHP use `TabOrchestrator.cs` etc.; the tree is the same. A plain CRUD slice has no use case file until the first rule arrives. A sub-feature earns a folder only if both hold: the business owner named it, and deleting the folder removes the cut without touching another file. "A folder is a promise of ownership, and a technical role has no owner," so no `view/` or `data/` drawers inside a slice. Slices talk "through the front door" (the other slice's public contract), never by importing its internals.

**Shared vs per-feature.** `shared/` "is born empty and absent, and... code only moves up to it once reuse has proven itself in at least two real slices, written and working." No `utils/`: "what fits everywhere belongs nowhere." Infrastructure (route table, dependency graph, entry point) sits outside `features/` once. In the sample app only `applyLoyaltyDiscount` reached `lib/shared/` (ch. 22).

**DRY is about knowledge (ch. 5).** Hunt and Thomas: "Every piece of knowledge must have a single, unambiguous, authoritative representation within a system." "DRY forbids duplicating knowledge. About *text*, it says nothing at all." Two 10% discounts with different owners are **accidental duplication**: keep separate. The card fee `0.0349` in three differently shaped functions is one contract: unify now. The question: "do these two snippets change for the same reason?" When unsure, the rule of three (Fowler): extract on the third occurrence. Sandi Metz: "prefer duplication over the wrong abstraction." Same knowledge outside code counts: schema, docs, and the rule pasted into a prompt.

**YAGNI and KISS (ch. 4).** Jeffries: "Always implement things when you actually need them, never when you just foresee that you need them." Fowler's four costs of speculative functionality: build, carry, delay, repair. The decision flow: is it a test, refactor, or design? Then it is internal quality and "YAGNI has no opinion, let it in." Otherwise: does someone need this now? Real request: build. Guess: backlog and refuse. YAGNI "isn't a veto over what the user requests." KISS in Kelly Johnson's sense: repairable by the average mechanic in the field; "simplistic is code that cuts what pays off."

**SOLID as a filter (ch. 6).** SRP: "how many actors ask for changes in this file?" (slice by actor, not by verb). OCP: "does extending require editing what already works?" LSP: "can I swap the implementation without the caller noticing?" ISP: "does everyone who depends on this contract use all of it?" DIP: "does the use case know the implementation?" "A good principle is one where you know when NOT to apply it."

**CQS (ch. 16).** Meyer: "a method changes state or returns data, never both." A command returns the order's outcome (`SaveResult`); a query returns the answer (`LookupResult`) and the orchestrator publishes it as state. The hybrid `Tab payAndGetTab()` discards the write's Result: "the mutation shipped with no receipt." A pure use case is a query by Meyer's ruler; the whole gesture is "a query followed by a command," and the rule applies per method. FOCUS stops at **CQRS-lite**: "the logical split between commands and queries, with none of the distributed cost. One database, no events, no eventual consistency." "If it returns both, that's two methods."

## 7. Composition root and explicit dependencies (ch. 9)

- **Constructor Injection**: "every dependency comes in through the constructor, where any reader can see it." `PaymentOrchestrator(repository, gateway)` stops the signature from lying; a forgotten dependency becomes a compile error (`CS7036` in C#) instead of a Friday 7pm runtime failure.
- **Composition Root** (Seemann): "the one place in the program where concrete classes get instantiated and wired to each other," next to the entry point (`main`). "No class below `main` creates a dependency, none asks a global registry for anything." A `new ProcessorGateway()` inside a screen is "a clandestine piece of Composition Root"; "if you need more than one place to swap an implementation, the root has dissolved."
- **Pure DI before any container**: "DI is this, dependencies in the constructor plus a single place of assembly." A container "lives in the Composition Root and never leaks past it" and starts paying "once the graph has dozens of nodes and distinct scopes." Resolving a service is legitimate only inside the root (the Seemann/Bogard synthesis); "outside the root, never."
- **The FOCUS asymmetry**: "dependency injection is for the IO boundary, and only for it... Dependency for whoever touches the world. Data for whoever calculates."

| FOCUS piece | Gets DI? | What it gets |
|---|---|---|
| View | no | the ready state; no business dependency |
| Orchestrator | yes | the IO boundary's contracts, through the constructor |
| Use Case | no | data as parameters; stays a pure function |
| Repository/Gateway | is the endpoint | implements the contract; the concrete is born at the root |

- Interfaces exist "only where a real IO boundary exists (`PaymentGateway`, `TabRepository`, and each one earns its rent on the first test with a fake); no interface for use cases." Repositories get one from day one because "your tests will need an in-memory implementation by the first week; the swap isn't a hypothesis, it's routine" (ch. 6). Chapter 19: the test fake "COUNTS as a real implementation"; a single-implementation interface, a twin DTO, and a field-by-field mapper are "layer by ceremony." A pure `ReceiptFormatter` gets no interface either: "it takes a value and returns a value, without touching the world."
- Pitfalls: the locator wearing a `context`/`services` grab-bag; setter injection ("a half-built object that compiles"); the dissolving root.

## 8. Testing (ch. 17)

"Test what the piece promises, not how it delivers. A mock checks the how, and the how changes."

| Layer | Test strategy |
|---|---|
| View | shape: "firing the intent (the event) and checking how the result gets drawn" (ch. 10); trigger: a widget test only where there's a rendering conditional (`canPay` enabled/disabled); otherwise "Don't write a single test" |
| Orchestrator | flow test with the repository fake: event in, sequence of states out (`[Loading, Ready]`, `[Loading, Failed]`); ch. 10 calls this the integration test |
| Use Case | pure test, "no double at all": arrange data, call, compare the Result variant and its fields; cover thresholds (100 wins, 99 doesn't) and the rule's order |
| Repository | the fake for every consumer; integration against real infrastructure for the real one, "one per driver," or a SQL test such as pgTAP |

- The fake belongs to the contract, not the implementation: same interface, same three methods, a boolean flag instead of a socket. A second failure mode costs one overridden method (`FakeThatDoesNotSave`).
- Mocks (interaction checkers) couple the test to the implementation: the book shows a suite going red on a refactor with identical output. Use a mock only for a third-party SDK you cannot fake faithfully.
- "No fake ever catches a broken migration": that is what the integration test is for.
- "The shape of your suite is a consequence of your architecture, not a choice you make before you start coding."
- Pitfalls: the fake that lies (keep it on the same interface, grow it in the same commit as the real one); chasing 100% coverage; testing a View with no conditional.

## 9. FOCUS in C#

What the book states about C# and .NET:
- Types: `abstract record` families with `sealed record` variants (10-01), `record` + `with` for copy-with-change (ch. 7). "The hierarchy is closed by convention, not by the compiler, so a `switch` over `TabResult` emits a warning instead of an error when a case is missing, and the code needs a dead arm that never runs" (ch. 10). That `_ => throw` arm guards a programmer defect; it is not a domain exception.
- Exhaustiveness: CS8509 "isn't an error, it's warning" (ch. 18). Workarounds: `OneOf` with a mandatory `Match` (ch. 14, snippets/14-01.cs), or `abstract record` + private constructor + hand-written `Match<T>` with one delegate per variant (snippets/en/18-06.cs), plus `WarningsAsErrors` in the `.csproj`. "A warning nobody reads isn't protection."
- Use case: "C# has no standalone functions," so the rule is a `public static` method in a verb-named class, `SplitTab.Execute(tab, people)` (ch. 11, snippets/en/11-01.cs) or `ApplyLoyaltyDiscount(Tab tab, int loyaltyPoints)` returning `OneOf<DiscountApplied, NotEligibleForDiscount, ItemOutOfStock>` (ch. 14; snippets/14-01.cs carries the Portuguese identifiers). No dependencies, no interface.
- Repository: `interface ITabRepository`; results as interfaces (`LookupResult`, `SaveResult`) because "a `record` in C# is a class, and a class inherits from only one," so `InfraFailure` implements both; the single `catch (System.IO.IOException)` returns `new InfraFailure(Failure.NoConnection)` (ch. 15, snippets/15-01.cs).
- Orchestrator: "C# is MVVM's home turf": a ViewModel whose `State` setter raises `INotifyPropertyChanged` (ch. 13, snippets/13-02.cs), or a class with `event Action<TabResult>` (10-01.cs), taking `ITabRepository` and the use case delegate through the constructor.
- View: Blazor `.razor` with `[Parameter] TabData Data` and `[Parameter] Action<TabEvent> OnEmit` (ch. 12, snippets/en/12-02.cs).
- Composition: Pure DI first (`new PaymentOrchestrator(repository, gateway)` in `Main`), then the same graph in `ServiceCollection` with `AddSingleton<ITabRepository, ServerRepository>()`; "the orchestrator doesn't know whether it came from a `new` or from a container" (ch. 9, snippets/en/09-01.cs). CQS pair as a class with expression-bodied members (snippets/en/16-02.cs).

**The orchestrator in C# is the Mediator pattern, in any implementation.** The house rule (stakeholder, 2026-09-15): a mediator plays exactly the role the book gives the BLoC in chapter 13, an event goes in, a handler runs, one new state comes out (here, the handler's return value). Which library provides it does not matter: MediatR, Mediator (the source-generated one), Wolverine, Brighter, or a hand-written `IRequest<TState>` / `IHandler<TRequest, TState>` pair with a dispatcher wired at the composition root. The book itself does not map the pattern to a piece (its only mention of MediatR is Jimmy Bogard's credential in the Service Locator debate of chapter 9); the mapping below is the house adaptation, consistent with the table:
- Request handler = orchestrator. The request (`IRequest<TState>`, a command or query record) is the event; the handler fetches from the injected `ITabRepository`, calls the static use case, tells the repository to save, and returns exactly one state. The book's C# orchestrator *publishes* state through a property or event rather than returning it; returning it from a handler is the same contract in request/response form, and the exhaustive `TState` family is the channel. All chapter 13 review rules apply to the handler body: no business `if`, no cache, one exhaustive switch over the Result, one handler per request, events processed one at a time.
- Notifications (`INotification`, published to many handlers) are a second channel and are not the orchestrator's state; use them only for side effects that are not the outcome the View is waiting for (inference).
- Use case = `public static` method (or a class with no constructor dependencies) returning `OneOf<...>` or a sealed record family with `Match`. Never registered in the container, never behind an `IUseCase`.
- Repository = the injected interface, the only `try/catch`, registered at the root.
- View = controller action or minimal API endpoint (server) or the Blazor component (UI): converts the HTTP gesture into the request, sends it through the mediator, maps the returned state to a response. Chapter 12 already describes the server View as "a controller that converts the HTTP gesture into an event, and a template that repeats the state... with no rule along the way."
- Pipeline behaviors (validation, logging) sit at the boundary; a behavior that compares business values is Card 1 in disguise (inference).

## 10. Anti-patterns (ch. 19)

| Card | Tell-tale sign in the diff |
|---|---|
| 1. Business rule in the orchestrator | a discount, eligibility, or total computed inside the event handler; "that if is business, it doesn't live here" |
| 2. Use case that hits the database | `applyLoyaltyDiscount(repository, tab)`: the signature picked up a dependency "just this once" |
| 3. Generic repository | public `Repository<T>` / `query("table=4")`: string filters leaking the database's language into every caller |
| 4. Layer by ceremony | `ITabRepository` with one implementation, `TabDto` identical to the model, a field-by-field mapper: "toll booths between the call and the data" |
| 5. Domain try/catch | `try { charge() } catch (e) { log(e); }` then "payment approved" unconditionally; the refusal swallowed |
| 6. Premature shared/ | `shared/helpers/` created on the second occurrence; an `isBirthday` tie-breaking boolean is the scar |

Legitimate exceptions the book keeps: a presentation `if` in the orchestrator; a thin choreography use case delegating every decision to pure functions; a private generic behind business verbs; an interface with two real implementations (the fake counts); the one `try/catch` at the boundary; `shared/` on the third occurrence of the same rule. The seventh wreck: fixing all six in one heroic pull request. Review in slice order (ch. 21): paths first (Card 6), then orchestrator (1), use case (2), repository (3), try/catch at three stops (5), ceremony at every file (4).

## 11. Legacy code and daily routine (chs. 20 and 23)

**Strangling legacy (ch. 20).** "Strangle by feature, never by layer": migrating a whole layer first "is a big-bang rewrite wearing a new hat." Legacy is "code with no tests" (Feathers), not old code.

| Step | Done criterion |
|---|---|
| 0. Choose the slice | commits this quarter times pain when it breaks; "a number defends the choice" |
| 1. Characterize | a table of cases plus a loop, run from outside through the public function; "if the legacy has a bug, the test expects the bug" |
| 2. Use cases | the rule becomes a pure function; "rule tests with literals, no test double" |
| 3. Adapter | the old code behind the slice's repository interface; "new slice never sees a throw from the legacy" |
| 4. View + orchestrator | the same characterization, byte for byte, "lost cent included" |
| Don't migrate | stable code, end of life, about to be bought, or the full rewrite (Spolsky's "single worst strategic mistake") |

"Migration changes structure; a fix changes behavior. Never in the same commit." "While we're at it..." turns a one-week migration into a three-month swamp. Duplication between the new use case and the old controller during strangling "is scaffolding, not debt."

**Shipping increments (ch. 23).** "Spec first, slice second, pure test in between: the increment born that way has an address, a contract, and a judge." Before opening the editor: write what the change must do and must refuse (five lines is a spec); decide which slice it belongs in ("if the answer is 'three,' the design is asking for a conversation before the code"); write the rule's pure test, then the rule. **Drift** is "the gradual gap that opens between what the code does and what the project says it does"; when code contradicts the spec, fix the spec before the patch. Adoption is incremental: "Extract one rule into a pure function that returns a Result. Push the exception to the boundary in the next repository you touch. Group by feature the next time a folder gets born."

**Pocket rules from the chapter tips.** "Before you write the line, say its verb out loud. 'Draws' goes to the View, 'sequences' and 'formats' go to the orchestrator, 'decides' goes to the use case, 'stores' goes to the repository." "If you don't know which layer the code belongs in, it isn't ready to be written yet" (Tip 10). "Explicit dependencies show up in the constructor; hidden dependencies show up on call" (Tip 9). "Translate the architecture, not the syntax" (Tip 18). "Never accept an error from an AI that the compiler wouldn't have caught" (Tip 3).

## 12. Sources the book names

- Alistair Cockburn, Ports and Adapters (2005). Robert C. Martin, "The Clean Architecture" (2012) and *Clean Architecture* (2017); "Solid Relevance" (2020, blog.cleancoder.com).
- Mozaic Works / Alex Bolboacă, "Is Hexagonal Architecture Overengineering?": https://mozaicworks.com/blog/is-hexagonal-architecture-overengineering
- Jimmy Bogard, "Vertical Slice Architecture" (2018, jimmybogard.com); "Service Locator is not an Anti-Pattern" (2022). Oskar Dudycz, "My thoughts on Vertical Slice Architecture": https://www.architecture-weekly.com/p/my-thoughts-on-vertical-slices-cqrs
- Mark Seemann, *Dependency Injection in .NET* (2011; 2nd ed. with van Deursen, 2019); "Dependency rejection" (2017, blog.ploeh.dk).
- Martin Fowler: Yagni (martinfowler.com/bliki/Yagni.html); "Inversion of Control Containers and the Dependency Injection pattern" (2004); *Refactoring* (1999, rule of three); *PoEAA* (2002, Repository); "Mocks Aren't Stubs" (2007); CQRS bliki; StranglerFigApplication (2004).
- Hunt and Thomas, *The Pragmatic Programmer* (1999; 2019 ed.). Sandi Metz, "The Wrong Abstraction" (2016, sandimetz.com). Kent C. Dodds, AHA (kentcdodds.com/blog/aha-programming) and the Testing Trophy (2018).
- Dan North, "CUPID, for joyful coding" (2022): dannorth.net/blog/cupid-for-joyful-coding
- Bertrand Meyer, *Object-Oriented Software Construction* (1988, CQS and OCP). Barbara Liskov (1987). Greg Young, "CQRS, Task Based UIs, Event Sourcing agh!" (2010).
- Scott Wlaschin, Railway-Oriented Programming (fsharpforfunandprofit.com/rop/). Rob Pike, "Errors are values" (go.dev/blog/errors-are-values, 2015).
- Gary Bernhardt, "Boundaries" (2012): destroyallsoftware.com/talks/boundaries
- Michael Feathers, "The Humble Dialog Box" (2002) and *Working Effectively with Legacy Code* (2004). Gerard Meszaros, *xUnit Test Patterns* (2007). Shai Yallin, "Fake, Don't Mock" (2023). Mike Cohn, *Succeeding with Agile* (2009).
- Elm guide (guide.elm-lang.org/architecture), Redux docs (redux.js.org, "Prior Art", style guide, FAQ), André Staltz (staltz.com, 2015), bloclibrary.dev, Flutter architecture guide (docs.flutter.dev/app-architecture).
- Ben Morris, "Why the generic repository is just a lazy anti-pattern" (ben-morris.com). Joel Spolsky, "Things You Should Never Do, Part I" (joelonsoftware.com, 2000). GitClear code-quality survey, 2026 edition (gitclear.com). OneOf: github.com/mcintyre321/OneOf.
- Sample app: github.com/JCKodel/focus-coffee. Ten-language snippets: https://focus.kodel.com.br/en/<lang>/NN-MM
