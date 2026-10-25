* **Documentation language:** English. Identifiers in English.
* **Verify:** `make verify`, which runs `test/greet_test.sh`, fast enough
  to run on every delivery. Green before anything is declared done. Slow
  tests: none.
* **Environments:** local only: the checkout, kept current by `make
  verify`; nothing runs anywhere else.
* **Design:** no screens.
* **Proof of a screen:** no screens.
* **Publish policy:** no environment beyond the local one. /apply's last
  words say the local checkout holds the delivery, verify green.
* **Context:** `context/` is committed; the repository stays with its
  author.
* **Delivery review:** a read-only agent on the session's model reading
  the whole delivery against its base: `git diff HEAD` of its paths,
  staged and unstaged, the commits a blocked delivery already made on its
  branch or worktree, and the files it created.
* **Manuals:** `docs/manuals/`: running it, `running-it.md`, written; the
  container and its worktrees, `worktrees.md`, written.
* **Milestone review:** the kit's readers, one area, `src/` and `test/`
  together, on the session's model.
* **Git:** a worktree per delivery. A delivery's page and build are one
  change: one merge. Reverting it undoes what git holds; no delivery acts
  outside git. The agent stages; it never commits or merges on its own,
  and asked, it takes the step the person names. /propose pushes the
  branch it creates, the remote checked for one first, so the line is
  taken in every clone; the hidden folder of the container is
  `.focus-kit/`, the branch prefix `focus-kit/`.
