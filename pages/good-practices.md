@def title = "Creating a package with good practices"
@def showall = true

# {{fill title}}

In this section we'll look into implementing and registering a package, following some good practices.

\toc

---

## Julia Registries

Julia has an officially maintained registry (https://github.com/JuliaRegistries/General) kept by the community.
This registry is readily available through the `pkg` interface (i.e., the `Pkg.jl` package).
TODO: expand Pkg information

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
However, since we usually want a bunch of other _goodies_, we can use the package `PkgTemplates` instead.

First, `pkg> add PkgTemplates` and `julia> using PkgTemplates`. Then simply run
```
julia> generate("PackageName")
```
A list of options will appear to allow customization.
Fow now, select `dir` and `plugins`.

The first option, `dir`, allows us to choose where to save our package. Julia's default `dev` environment is inside `.julia/dev/` in the home folder.
To avoid having to look for it, simply enter `.` (a single dot).

The second option gives as a wide range of plugins, many of which we want. In addition to the ones that are already selected, choose `Citation`, `Coveralls`, `Documenter`, `GitHubActions` and `RegisterAction`.
Their meaning are as follows:

- `Citation`: Creates a `CITATION.bib` file for citing package repositories.
- `CompatHelper`: Integrates your packages with CompatHelper via GitHub Actions. This automatically checks for updates on the dependencies and creates a pull request updating the version bounds.
- `Coveralls`: Sets up code coverage submission from CI to Coveralls.
- `Documenter`: Sets up documentation generation via Documenter.jl. The deploy depends on a CI, and in this case we're choosing GitHub Actions.
- `Git`: Creates a Git repository and a `.gitignore` file.
- `GitHubActions`: Integrates your packages with GitHub Actions. Currently the most used CI for Julia packages after Travis CI support for open source software went downhill.
- `License`: Creates a license file (defaults to using MIT).
- `ProjectFile`: Creates a default `Project.toml`.
- `Readme`: Creates a `README` file that contains badges for other included plugins.
- `RegisterAction`: Add a GitHub Actions workflow for registering a package with the General registry via workflow dispatch. See here for more information.
- `SrcDir`: Creates a module entrypoint.
- `TagBot`: Adds GitHub release support via TagBot. This automatically creates a git tag and a GitHub release.
- `Tests`: Sets up testing for packages.

After selecting these, simply accept the default options for the plugins using `d`.

**Warning**: When the process arrives at `Documenter`, you'll need to select how to deploy the documentation. We're using GitHub Actions, so select that.

The current default (2021-09-23) leaves us with the following structure:

- .github/
  - workflows/
    - CI.yml
    - CompatHelper.yml
    - register.yml
    - TagBot.yml
- docs
  - src
    - index.md
  - make.jl
  - Manifest.toml
  - Project.toml
- src
  - PackageName.jl
- test
  - runtests.jl
- .gitignore
- CITATION.bib
- LICENSE
- Manifest.toml
- Project.toml
- README.md

A `.git` folder is also present, but we'll ignore it.
TODO: Explain Manifest.toml somewhere.

## Uploading and checking

The repo starts with a commit and the repo setup (if you have setup `git`).
Your next steps:
- Create the repo on GitHub;
- (optional) Go to [Coveralls](https://coveralls.io/repos/new), find the repo an turn coverage ON;
- (optional) Copy the repo **token** on Coveralls, and go to your github repo -> settings -> secrets; create a new secret called `COVERALLS_TOKEN` and paste your token there.
- (alternative to above) Remove/comment out the lines 39-40 on `CI.yml`;
- `git push`, and check your CI.

TODO: Example: docstrings + docs

You might have noticed that your Documentation action passes, but no documentation is available.
That is because the action needs a GitHub token to push to your repo

TODO: Example: dev'ing the package, running tests
TODO: Example: uploading, creating a pull request
