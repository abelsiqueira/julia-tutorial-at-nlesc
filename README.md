# Julia Tutorial @ NLeSC

Current plan (subject to large changes):

- -X - 0:00: Introduction, greeting, etc.
- 0:00 - 0:10: REPL, Jupyter, IDE
- 0:10 - 0:30: Main features and bugs
- 0:30 - 2:00: Creating a package: SequGen.jl
- 2:00 - 2:20: Parallel programming showcase
- 2:20 - 2:40: Usage of C/Fortran showcase
- 2:40 - 3:00: To be detailed

**Creating a package: SequGen.jl description** (relative times)
- 0:00 - 0:10: Create SequGen with PkgTemplate and push.
- 0:10 - 0:20: Create `Sequence`, `Constant`, `sample`, `Trend`.
- 0:20 - 0:30: Create tests.
- 0:30 - 0:40: Document, publish the docs.
- 0:40 - 0:50: Create `SineWave`, `GaussianNoise`, tests, and write first example.
- 0:50 - 1:00: Create `SumOfSequences` with tests.
- 1:00 - 1:30: To be detailed.

See https://abelsiqueira.github.io/julia-tutorial-at-nlesc for the published version.

## Running locally

This website uses the structure of the root website under it to avoid duplicating updates to the css and layout.
Therefore, you need to copy the `_layout`, `_css` and `_libs` folders:

    wget https://github.com/abelsiqueira/abelsiqueira.github.io/archive/refs/heads/main.zip
    unzip main.zip
    mv abelsiqueira.github.io-main/{_layout,_css,_libs} .
    rm -rf abelsiqueira.github.io-main main.zip

Now open julia, activate and instantiate the environment.

    julia> # press ]
    pkg> activate .
    (julia-tutorial-at-nlesc) pkg> instantiate

Finally, use `Franklin` and `serve`

    pkg> # press backspace
    julia> using Franklin
    julia> serve()

Go to https://localhost:8000.