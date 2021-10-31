@def title = "Installation and preparation"
@def showall = true

# {{fill title}}

\toc

In this tutorial we'll use Julia in two or three ways:
- On the interactive terminal (called REPL); and/or
- On a Jupyter notebook; and
- On an editor for the package development.

All of them need you to have a binary `julia` or `julia.exe` accessible.

**And please download version 1.6.X**

## Binary executable

\detbegin{Windows}

Probably the easiest way is to download the installer on the [Julia Downloads page](https://julialang.org/downloads/).

\detend
\detbegin{MacOS and Linux}

For MacOS and Linux, you could also follow the [Julia Downloads page](https://julialang.org/downloads/). But I also maintain an installer called [Jill](https://github.com/abelsiqueira/jill), which you can download using
```
curl -fsSL https://raw.githubusercontent.com/abelsiqueira/jill/master/jill.sh > jill.sh
```
And enter
```
sudo bash jill.sh -v 1.6-latest
```
Check if the installation was successful with
```
julia -v
```

Your package manager might also have `julia` available, but make sure the version to be installed is the newest one.

\detend
## Jupyter notebook (Julia's kernel)

You can run Julia in Jupyter in two ways:
- Using your existing Python + Jupyter installation;
- Installing a standalone Julia Jupyter installation.

\detbegin{Existing Python + Jupyter installation}

I'm assuming that you have `python` and the Jupyter notebook for `python` working properly, so that you only need to install Julia's kernel.
Open `julia`. Then you should see a welcome text and a prompt like `julia> `.

- Enter `ENV["PYTHON"] = "..."` where `...` should be the path to your python installation.
  - For instance, for me it's `/usr/bin/python`.
- Enter `using Pkg`.
- Enter `Pkg.add("IJulia")` (Capital i and capital j).

\detend
\detbegin{Standalone}

Open `julia`. You should see a welcome text and a prompt like `julia> `.

- Press `]` and the command prompt will change to `(@v1.6) pkg> `.
- Enter `add IJulia` (Capital i and capital j).
  - This will install a minimal Python + Jupyter distribution via miniconda.
- To start the notebook, enter `using IJulia` and then `notebook()`.

\detend

## Editor/IDE

Julia is supported by a few editors and IDEs.
An incomplete list of editors is available on the [main page](https://julialang.org).
One of the main requirements for an editor to support Julia is the latex-unicode autocompletion feature.

Since 2019, the most used and recommended IDE is [VS Code](https://www.julia-vscode.org/) (see also [the official visualstudio docs](https://code.visualstudio.com/docs/languages/julia).)

On your VSCode, you just have to search for the `julia` extension.
If your `julia` executable is not on the PATH, then you also have to inform its path on the **"Julia: Executable Path"** setting.

Alternatively, the other four common options are:
- [Vim](https://github.com/JuliaEditorSupport/julia-vim)
- [Emacs](https://github.com/JuliaEditorSupport/julia-emacs)
- [Sublime text](https://github.com/JuliaEditorSupport/Julia-sublime)
- [Notepad++](https://github.com/JuliaEditorSupport/julia-NotepadPlusPlus)

\detbegin{More on VSCode}

If you choose to use VSCode, you should make some tests, like:
- Opening a Julia terminal
  - Open the "Command Palette" (`Ctrl+Shift+P`);
  - Find "Julia: Start REPL" (`Alt+J Alt+O`);
- Sending commands to REPL
  - Create a new file and save as `.jl`;
  - write `2 + 3` on that file;
  - `Ctrl+Enter` to run a line;
  - `Shift+Enter` to run the whole file.

The first time you try to run commands on Julia VSCode, it will prepare the language server, and that might take a while.

When you open a Julia project folder, the environment should be automatically set.
You can change it on the `julia env` toolbar option.

\detend
## Pkg - Install packages

Julia comes with a built-in package manager: `Pkg`.
- `Pkg` is itself a package;
- it's always available because it's part of the stdlib;
- it's a very robust manager, that deals with conflicts and can handle environments;
- it connects to the official Julia registry to resolve package names;
- it also allows for unregistered packages to be installed.

To access the package manager, open the Julia terminal and press `]`.
You should see a prompt like `(@v1.6) pkg> `.
Enter `help` for a list of commands.
Here are some commands that will be useful in this tutorial:

- `activate`: set the primary environment that the package manager manipulates
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
- `status`, st: summarize contents of and changes to the environment
- `test`: run tests for packages
- `update`, up: update packages in manifest

In this tutorial, we'll need to install several packages.
You can copy and paste the following command:
```
pkg> add BenchmarkTools, CSV, DataFrames, JuMP, Plots, Revise, Unitful, UnitfulRecipes
```