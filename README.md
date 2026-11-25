# yard-md

The documentation of installed gems as plain Markdown, for people and coding agents to read.

yard-md reads a gem's own documentation with [YARD](https://yardoc.org) — its source comments and the prose files it ships — and writes it as Markdown pages, one per class or module.

## Why?

Coding agents write code against a gem from what they remember of it, not from the documentation of the version installed. That documentation exists, in the gem's comments and files, but not as text an agent can grep in one place. yard-md puts it there.

## Usage

```sh
gem install yard-md
cd my-project
yard-md
```

Run in a project, yard-md documents every gem Bundler resolves for it on this platform, each into `<output dir>/<gem>-<version>/`. The output directory is `$XDG_CACHE_HOME/gem-docs`, or `~/.cache/gem-docs` when that is unset, empty or relative, unless given as the argument: `yard-md docs`. A gem whose directory already exists is skipped, so a second run writes nothing and the output directory is the cache, shared by every project. `yard-md --force` rebuilds the project's gems whose directories exist, for when a newer yard-md writes them differently, and leaves other projects' gems alone.

Each gem's directory holds:

- a page per class and module YARD documents, at YARD's own paths (`ActiveRecord/FinderMethods.md`): the public API, plus whatever visibility the gem's `.yardopts` asks for, without `@private` and `@api private`;
- its README and the files its `.yardopts` names, as they are;
- its `doc/`, `docs/`, `examples/`, `example/`, `samples/` and `sample/` directories, copied whole;
- `.index.json`, the index `mdri` reads.

`yard-md --help` says the same in short.

## Reading

```sh
mdri Faraday                   # its classes and modules, then its methods
mdri Faraday::Connection#get   # that instance method's documentation
mdri Faraday.new               # that class method's documentation
```

Run in the same project, `mdri` answers from the documentation yard-md wrote for its bundle, at the versions the bundle resolves, addressed by constant as YARD's `yri` is. Every gem in the bundle answers: a namespace several gems add to (`Rails`) lists them all, and a class a gem reopens (`String`, by activesupport) answers with that gem's methods. It reads the output directory yard-md writes, or the one given after the constant, and writes nothing. It answers from an index yard-md writes beside each gem's pages, so a gem documented by an earlier yard-md does not answer until `yard-md --force` documents it again. `mdri --help` says the same in short.

Docstrings written in RDoc markup (`+code+`, `<tt>`, `*bold*`, `_em_`, `= Heading`, labelled lists) come out in Markdown; code examples are left as they are.

## License

MIT
