@def title = "Installation and preparation"
@def showall = true

# {{fill title}}

\toc

In this tutorial we'll use Julia in two or three ways:
- On the interactive terminal (called REPL); and/or
- On a Jupyter notebook; and
- On an editor for the package development.

All of them need you to have a binary `julia` or `julia.exe` accessible.

**Please download version 1.6.X**

## Binary executable

### Windows

The easiest way of probably to download the installer on the [Julia Downloads page](https://julialang.org/downloads/).

TODO: Ask someone using Windows what's the best way.

### MacOS and Linux

For MacOS and Linux, you could also follow the [Julia Downloads page](https://julialang.org/downloads/), but I also maintain a installer called [Jill](https://github.com/abelsiqueira/jill).
You can download it with
```
curl -fsSL https://raw.githubusercontent.com/abelsiqueira/jill/master/jill.sh > jill.sh
```
And enter
```
sudo bash jill.sh -v 1.6-latest
```
Test that the installation is succesful with
```
julia -v
```

Your package manager might also have `julia` available, but make sure the version is updated.

## Jupyter notebook (Julia's kernel)

You can install Julia for Jupyter in two ways:
- Using your existing Python + Jupyter installation;
- Install a standalone Julia Jupyter installation.

### Existing Python + Jupyter installation

I'm assuming that you have `python` and the Jupyter notebook for `python` working properly, so that you only need to install Julia's kernel.
Open `julia`. You should see a welcome text and a prompty like `julia> `.

- Enter `ENV["PYTHON"] = "..."` where `...` should be the path to your python installation.
  - For instance, for me it's `/usr/bin/python`.
- Enter `using Pkg`.
- Enter `Pkg.add("IJulia")` (Capital i and capital j).

### Standalone

Open `julia`. You should see a welcome text and a prompty like `julia> `.

- Press `]`. This should change the prompt to `(@v1.6) pkg> `.
- Enter `add IJulia` (Capital i and capital j).
  - This will install a minimal Python + Jupyter distribution via miniconda.
- To start the notebook, enter `using IJulia` and then `notebook()`.

## Editor/IDE

Julia is supported by a few editors and IDEs.
A possibly incomplete list is available on the [main page](https://julialang.org).
One of main requirements for an editor to support Julia is the latex-unicode autocompletion feature.

Since around 2019, the most used and recommended IDE is [VS Code](https://www.julia-vscode.org/) (see also [the official visualstudio docs](https://code.visualstudio.com/docs/languages/julia).)

On your VSCode, you just have to search for the `julia` extension.
If your `julia` executable is not on the PATH, then you also have to inform its path on the **"Julia: Executable Path"** setting.

Alternatively, the four options below are common:
- [Vim](https://github.com/JuliaEditorSupport/julia-vim)
- [Emacs](https://github.com/JuliaEditorSupport/julia-emacs)
- [Sublime text](https://github.com/JuliaEditorSupport/Julia-sublime)
- [Notepad++](https://github.com/JuliaEditorSupport/julia-NotepadPlusPlus)

### More on VSCode

If you choose to use VSCode, you should test the following:
- Open a Julia terminal
  - Open the "Command Palette" (`Ctrl+Shift+P`);
  - Find "Julia: Start REPL" (`Alt+J Alt+O`);
- Send commands to that REPL
  - Create a new file and save as `.jl`;
  - write `2 + 3` on that file;
  - `Ctrl+Enter` to run a line;
  - `Shift+Enter` to run the whole file.

The first time you try to run commands on the Julia VSCode, it will prepare the language server, and that might take a while.

When you open a Julia project folder, the environment should be automatically set.
You can change it on the `julia env` toolbar option.

## Pkg - Install packages

Julia comes with a built-in package manager: `Pkg`.
`Pkg` is itself a package, but it's part of the stdlib, so it's always available.
It is a very robust manager, that deals with conflicts and can handle environments.
`Pkg` connects to the official Julia registry to resolve package names.
However, it also allows for unregistered packages to be installed.

To access the package manager, open the Julia terminal and press `]`.
You should see a prompt like `(@v1.6) pkg> `.
Enter `help` for a list of commands.
Here are some:
The following will be useful in this tutorial:

- `activate`: set the primary environment the package manager manipulates
When you `activate` a different environment, you can see it before the `pkg` prompt.
E.g.:
```
julia> # press ]
(@v1.6) pkg> activate potato
(potato) pkg> activate .
(current-wd) pkg> activate
(@v1.6)
```

- `add`: add packages to project
You can `add PackageName1, PackageName2` or `add GitHubLink`, for instance.

- `remove`, rm: remove packages from project or manifest
- `status`, st: summarize contents of and changes to environment
- `test`: run tests for packages
- `update`, up: update packages in manifest

In this tutorial, we'll need to install several packages.
You can copy paste the following command:
```
pkg> add BenchmarkTools, CSV, DataFrames, JuMP, Plots, Revise, Unitful, UnitfulRecipes
```