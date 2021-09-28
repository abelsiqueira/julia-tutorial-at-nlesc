@def title = "Julia Tutorial @ NLeSC"
@def image = "code.jpg"
@def image_text = "Julia Tutorial @ NLeSC"
@def image_text_sec = "(WIP)"

# Introduction

TODO: add reference
Julia was created in 2010 by someone with an ambitious goal: be as fast as lower-level languages but with a higher-level syntax. It achieves this by means of just-in-time compilation: when a code is executed for the first time, the compiler is called. The second time the code is called, it is already compiled and can be executed quickly.

Since it's public release in 2012 it has atracted many researchers and software developers in part for these reasons.
However, it is also a very pleasant language to write code in, largely for its linear algebra capabilities.
Julia also provides _multiple dispatch_, which allows some very interesting packages to thrive.

Julia is inspired by several languages and manages to attract people from different backgrounds.
It lacks a higher adoption rate, in part because it's very new, compare to other languages like Python and R.
Julia 1.0 was release in 2018, and it's current Long Term Support version, 1.6, was relesed in 2020.
In some areas, however, it has seen a very large adoption.
Two main groups being former MatLab users, and optimization developers.

TODO: refactor and expand these paragraphs.

In this tutorial, we'll take a glimpse of what Julia can and can't do (well), comparing it agaisnt Python.
At the end of this tutorial, you should

- Know the main syntax differences between Julia and Python;
- Have a grasp of the main differences with Python;
- Have a grasp of the main features;
- Have implemented a few examples;
- Know at least one reason to use Julia instead of Python;
- Know at least one reason to not use Julia;
- Have seen a Fortran code being called in Julia (preferably, you done it yourself);
- Have seen what are the requirements to publish a package in the Julia registries.
  
This tutorial assumes you know some Python so that we can freely compare to it.

**Table of contents**:

- Installation
  - Using [jill](https://github.com/abelsiqueira/jill) for Linux or Mac
  - The default site for Windows
- IDE
  - VSCode
  - Vim/Emacs
- Main features and bugs
  - [Main syntax differences](pages/syntax/)
  - [Structures, not classes](pages/structures/)
  - [Type inference is hard](pages/type-inference/)
- [Creating a package: SequGen.jl - demonstration of good practices](pages/sequgen/)
  - PkgTemplates
  - Documenting
  - Unit tests
  - JuliaFormatter
  - Registering a package
- Calling Fortran and C code
- [A more complicated example of multiple dispatch](pages/multiple-dispatch/)
- [Python's scipy.optimize vs Julia](pages/optimization/)
- Speed demonstration against Python
  - Example should be short

- Parallel computing
- Package examples
  - JuMP
  - DrWatson
  - Franklin
  - Genie
  - Pluto
  - Flux
- Questions
  - Is the code portable?
  - When should I use Julia instead of Python?
  - When should I use Python instead of Julia?
  - Can I use Rest API to talk with other applications?

- Left out/maybe if there's more time
  - GPU computing