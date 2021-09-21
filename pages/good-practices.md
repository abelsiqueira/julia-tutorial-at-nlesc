@def title = "Good practices"
@def showall = true

# {{fill title}}

In this section we'll look into implementing and registering a package, following some good practices.

\toc

---

## Julia Registries

Julia has an officially maintained registry (https://github.com/JuliaRegistries/General) kept by the community.
This registry is readily available through the `pkg` interface (i.e., the `Pkg.jl` package).
(TODO: expand Pkg information).

This registry has few requirements, but some suggestions.
Following these suggestions allow for automatic acceptance of your package.
Otherwise, a discussion may be started to suggest changes to your package and a manual acceptance may occur.
From the README:

- The only restriction: "Registered packages must have an **Open Source Initiative approved license**..."
- Use the [Registrator](https://github.com/JuliaRegistries/Registrator.jl) bot.
- The name
  - starts with upper case letter;
  - contains only ASCII characters;
  - contains one lower-case letter;
  - is at least 5 characeters long;
  - does not include "julia" or starts with "Ju";
- The repo ends with `/PackageName.jl.git`.
- There is an upper bound `[compat]` entry for `julia`.
- All dependencies have upper bounds in `[compat]`.
- The package is installable.
- Code can be downloaded.
- The package is loadable.
- The name is sufficiently distant from other names.

For updates of existing packages, the conditions for auto-merging are essentially the same as above, with the addition of:

- The version numbering is incremented properly (no skips).
- If it's a patch release, then it doesn't drop support for any `julia` version (i.e., the `[compat]` is not restricted).

## Creating a package

Not much is needed to create a proper package in Julia.
It needs to follow a basic structure of the form
```
PackageName.jl
- src/
  - PackageName.jl
- test/
  - runtests.jl
- Project.toml
```
The entry point of the package is the `src/PackageName.jl` file. The `test/runtests.jl` file is run when you try to `pkg> test` a package.
Finally, the `Project.toml` file contains several information about the package:
- `name`: Name
- `uuid`: A unique identifier
- `authors`: A list of authors
- `version`: A SemVer version.
- `[deps]`: A list of packages and their UUIDs.
- `[compat]`: A list of packages and the versions needed for this package.
- `[extras]`: A list of additional packages used for testing.
- `[targets]`: Additional targets (and their required packages). Currently only supports `test` for the testing packages.

An easy way to generate a basic skeleton for pacakges is using the built-in `pkg> generate PackageName`.
However, since we usually want a series of other _goodies_, we can use the package `PkgTemplates` instead.