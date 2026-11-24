# yard-md

The documentation of installed gems as plain Markdown, for people and coding agents to read.

yard-md reads a gem's own documentation with [YARD](https://yardoc.org) — its source comments and the prose files it ships — and writes it as Markdown pages, one per class or module.

## Why?

Coding agents write code against a gem from what they remember of it, not from the documentation of the version installed. That documentation exists, in the gem's comments and files, but not as text an agent can grep in one place. yard-md puts it there.

## Usage

```sh
gem install yard-md
cd my-project
yard-md ~/.cache/gem-docs
```

Run in a project, yard-md documents every gem Bundler resolves for it on this platform, each into `<output dir>/<gem>-<version>/`. A gem whose directory already exists is skipped, so a second run writes nothing and the output directory is the cache, shared by every project that points at it.

Each gem's directory holds:

- a page per class and module YARD documents, at YARD's own paths (`ActiveRecord/FinderMethods.md`), public API only;
- its README and the files its `.yardopts` names, as they are;
- its `doc/`, `docs/`, `examples/`, `example/`, `samples/` and `sample/` directories, copied whole.

Docstrings written in RDoc markup (`+code+`, `<tt>`, `*bold*`, `_em_`, `= Heading`, labelled lists) come out in Markdown; code examples are left as they are.

## License

MIT
