<!--
Add here global page variables to use throughout your website.
-->
+++
author = "Abel Soares Siqueira"
mintoclevel = 2

# Add here files or directories that should be ignored by Franklin, otherwise
# these files might be copied and, if markdown, processed by Franklin which
# you might not want. Indicate directories by ending the name with a `/`.
# Base files such as LICENSE.md and README.md are ignored by default.
ignore = ["node_modules/", "_ignore/", "SequGen.jl/"]

# RSS (the website_{title, descr, url} must be defined to get RSS)
generate_rss = true
website_title = "Julia Tutorial at NLeSC"
website_descr = "Julia Tutorial at NLeSC"
prepath     = get(ENV, "PREVIEW_FRANKLIN_PREPATH", "julia-tutorial-at-nlesc")
website_url = get(ENV, "PREVIEW_FRANKLIN_WEBSITE_URL", "abelsiqueira.github.io")
+++

<!--
Add here global latex commands to use throughout your pages.
-->
\newcommand{\R}{\mathbb R}
\newcommand{\scal}[1]{\langle #1 \rangle}
\newcommand{\cfig}[1]{
  ~~~
  <figure style="text-align: center">
  ~~~
  \fig{#1}
  ~~~
  </figure>
  ~~~
}
\newcommand{\cfigalt}[2]{
  ~~~
  <figure style="text-align: center">
  ~~~
  \figalt{#1}{#2}
  ~~~
  <figcaption>#1</figcaption>
  </figure>
  ~~~
}
\newcommand{\detbegin}[1]{
  ~~~
  <details>
  <summary><span class="details-summary">#1</span></summary>
  ~~~
}
\newcommand{\detend}{
  ~~~
  </details>
  ~~~
}