# This file was generated, do not modify it. # hide
using Printf
for T in [Float16, Float32, Float64, BigFloat]
  x, fx, iter = newton_parametric(x -> x^2 - 2, x -> 2x, one(T))
  @printf("√2 ≈ %20.16e, (√2)² - 2 ≈ %20.16e\n", x, x^2 - 2)
end