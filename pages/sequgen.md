@def title = "Creating a package: SequGen.jl - demonstration of good practices"
@def showall = true

# {{fill title}}

In this section we'll look into implementing and registering a package, following some good practices.

\toc

---

## What is/will be SequGen

SequGen.jl will be a package to implement time series/sequences generation on Julia.
It is based on the homonymous NLeSC project [sequgen](https://github.com/sequgen/sequgen).

In this tutorial, our package will generate simple time series that we'll be able to add up and create useful synthetic data.
We'll work with `struct`s and showcase _multiple dispatch_ in the process.

## Create the package skeleton

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
julia> generate("SequGen")
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

## The basics

The basic idea of our package will be:
- We have different types of _sequences_;
- We want to _sample_ these sequences at different _intervals_ or _ranges_.

For instance, to describe the average temperature of a city per day we might say we need:
- A constant value to set the mean value;
- A sine wave for the yearly oscillation;
- A random noise generator.

With this description, we can ask for sample of `N` points in the interval starting at _60 days_ and ending at _120 days_. If we ask for a new sample, we'll get different noise, but the rest will be the same.

In Python, we could create a base class `Sequence` and a method `sample(interval)`, or `sample(start, end, length)`.
We would then implement classes `Constant`, `SineWave`, `GaussianNoise` deriving from `Sequence` as specialize the `sample` method for these cases.

In Julia, it won't be so different in practice. We'll start by creating an abstract type for `Sequence` and the function `sample`.

```julia
# File src/SequGen.jl
module SequGen

export Sequence
export sample

abstract type Sequence end

function sample end

# includes will go here

end # module
```

Here, `export`ing only gives visibility to the user that uses our package.
Otherwise, he would have to write `SequGen.sample` to specify where `sample` comes from.

The `function sample end` simply declares that the `sample` function exists.
This line is not really necessary, but it's useful to centralize the basic API information.
We'll also add docstrings to this function, instead of somewhere else.

Next, create a file `constant.jl` and add the line `include("constant.jl")` on `src/SequGen.jl`.

```julia
# File constant.jl
export Constant

struct Constant <: Sequence
  x
end

sample(seq::Constant, t::AbstractVector) = fill(seq.x, length(t))
```

TODO: What's the word instead of field?
Now, `Constant` is a subtype of `Sequence` that contains a field `x` of indeterminate type (`Any`).
We also defined how the `sample` function behaves for a `Constant` and an `AbstractVector`: it returns a vector of size `length(t)` filled with `seq.x`.

This should already run on our REPL, so let's check.
- Open a Julia REPL inside the SequGen.jl base folder.
- Press `]` to enter `pkg>` mode.
- Change to the general environment with `pkg> activate` without arguments.
- It should read `(@v1.6) pkg>` (or a newest version).
- `pkg> add Revise, Plots, Unitful, UnitfulRecipes`.
- Activate the current environment with `pkg> activate .`.
- It should have changed to `(SequGen) pkg> `.
- Return to `julia>` mode by pressing the _backspace_.
- Enter `using Revise`.
- Enter `using SequGen`.
- Enter `s = Constant(2.3)`.
- Enter `sample(s, 1:3)`. It should output
```
3-element Vector{Float64}:
 2.3
 2.3
 2.3
```
- Rejoice.


TODO: Example: docstrings + docs

You might have noticed that your Documentation action passes, but no documentation is available.
That is because the action needs a GitHub token to push to your repo

TODO: Example: dev'ing the package, running tests
TODO: Example: uploading, creating a pull request
