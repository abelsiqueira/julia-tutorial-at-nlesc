@def title = "Julia Tutorial @ NLeSC"
@def image = "code.jpg"
@def image_text = "Julia Tutorial @ NLeSC"
@def image_text_sec = "(WIP)"

# Introduction

Julia was created around 2010 by someone with an ambitious goal: to be as fast as lower-level languages but with a higher-level syntax. This goal is achieved through the just-in-time compilation, i.e. when a code is executed for the first time, the compiler is called. The second time the code is called, it is already compiled and can be executed quickly.

Since its public release in 2012, Julia has attracted many researchers and software developers in part due to these reasons. It is inspired by several languages, a very pleasant and intuitive language to write code in, largely for its linear algebra capabilities. Besides that, Julia also provides _multiple dispatch_, which allows some very interesting packages to thrive.

Although managing to attract people from different backgrounds, Julia has a slow higher adoption rate, in part because it's very new, compared to other languages like Python and R. In 2018, Julia 1.0 was released, and in 2021 its current Long Term Support version, 1.6, was released. The main groups which seem to have a very large adoption rate are former MatLab users, and optimization developers, where I come from.

More information about Julia's creation can be seen through papers related to it [here](https://julialang.org/research/).

In this tutorial, we'll see a glimpse of what Julia can and can't do (well), and compare it against Python.
At the end of this tutorial, you should

- Know the main syntax differences between Julia and Python;
- Have a grasp of the main differences with Python;
- Have a grasp of the main features;
- Have implemented a few examples;
- Know at least one reason to use Julia instead of Python;
- Know at least one reason to not use Julia;
- Have seen a Fortran code being called in Julia (preferably, you'll have done it yourself);
- Know the requirements to publish a package in the Julia registries.
  
This tutorial assumes you know some Python so that we can freely compare to it.

**Table of contents**:

- Basics
  - [Install Julia, an IDE, and some packages](pages/basics/installation/)
  - [Main syntax differences](pages/basics/syntax/)
  - [Visualization packages](pages/basics/visualization/)
  - [Type inference is hard](pages/basics/type-inference/)
- [Creating a package: SequGen.jl - demonstration of good practices](pages/sequgen/)
- Extra topics
  - [Calling Fortran and C code](pages/extra/interoperability/)
  - [Nonlinear Optimization in Python vs Julia](pages/extra/optimization/)
  - [Parallel computing](pages/extra/parallel/)
  - [More packages](pages/extra/more-packages/)
- [Frequently Asked Questions](pages/faq.md)

- Left out/maybe if there's more time
  - GPU computing
  - Rest API
