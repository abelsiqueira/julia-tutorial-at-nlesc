# This file was generated, do not modify it. # hide
using BenchmarkTools

β₀ = zeros(p + 1)
@benchmark optimize(
  β -> myfun(β, X, y),
  (out, β) -> myjac(out, β, X, y),
  β₀,
  LBFGS(),
  Optim.Options(
    g_tol = 1e-4,
  ),
)