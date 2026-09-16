# Backend

**Not applicable.** focus-kit has no server, and this file exists to say so
rather than to be filled in later.

The kit is one bash script and a set of markdown files. There is no API, no
database, no queue, no cache, no storage, no authentication and no
deployment. Nothing runs between invocations: `bin/focus-kit` starts, copies
files into a directory, prints what it did, and exits. There is no state to
migrate, no environment to reach, no secret to keep out of this document,
and nothing to observe.

The two places a reader might look for backend concerns are covered
elsewhere. The commands that build, check and run the kit are in
`docs/02-Backend.md`'s usual §2, which here is `docs/05-Process.md` §4, with
the verify command. The only boundary the kit crosses, the filesystem, is in
`docs/01-Architecture.md` §5, along with the single network call it makes
(fetching the uv installer) and the one place it touches the user's home
directory.

If the kit ever grows a server, this file is where it goes, and the delivery
that adds it fills the template's sections rather than appending to this
paragraph.
