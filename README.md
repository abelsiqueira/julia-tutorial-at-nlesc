# Julia Tutorial @ NLeSC

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