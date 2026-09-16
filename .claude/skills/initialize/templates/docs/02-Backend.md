# Backend

The server: how it is put together, how it runs, how it migrates, and the
conventions every migration and every endpoint follow. The overall design
is in `docs/01-Architecture.md`.

<!-- init: if the project has no server (a library, a CLI, a static site),
     replace everything below with one paragraph saying so and why, keep
     the file, and stop. -->

---

## 1. Topology

<!-- init: the services and how they connect: API, database, queue,
     cache, storage, auth, gateway, observability. A table of role →
     service. What is frozen (no service enters or leaves without an ADR). -->

## 2. Operation

<!-- init: the commands. Build, run locally, run tests, migrate, deploy,
     logs, status. One block, one line per command, in the form
     `make <target>` / `dotnet <verb>` / `<script>`. Every command
     idempotent; say so if one is not. -->

```
<!-- init: the command block -->
```

## 3. Environments and access

<!-- init: how one reaches each environment (connection string variable,
     tunnel, VPN, cloud console); what is versioned and what is secret and
     where the secret lives. Never write a secret here. -->

## 4. Migration convention

<!-- init: naming, one file per subject or incremental, how a migration is
     reviewed, what it must always contain (for example: every table is born
     with its authorization rule in the same migration). Whether migrations
     are squashed before the first real user, and the date that stops. -->

## 5. Authorization and privacy boundary

<!-- init: where a request is authenticated, where it is authorized, and
     the rule that decides what the client may receive. If the product has a
     privacy promise, this is the section that says how the server keeps it,
     and the test file that proves it. -->

## 6. Data

<!-- init: the aggregates and their tables or collections, one line each,
     pointing at docs/03-Domain.md for meaning. Storage of files, retention,
     backups. -->

## 7. Observability

<!-- init: where errors go, where slow queries show up, what is never
     logged (personal data, secrets, request bodies). -->
