# This file was generated, do not modify it. # hide
function newton(f, fder, x = 0.0; atol = 1e-6, rtol = 1e-6, max_iter = 1000)
  fx = f(x)
  iter = 0
  ϵ = atol + rtol * abs(fx)
  solved = abs(fx) < ϵ
  tired = iter ≥ max_iter
  while !(solved || tired)
    slope = fder(x)
    if abs(slope) < 1e-12
      error("0 derivative at x = $x")
    end
    x -= fx / slope
    fx = f(x)
    iter += 1
    solved = abs(fx) < ϵ
    tired = iter ≥ max_iter
  end
  return x, fx, iter
end
newton(x -> x - exp(-x), x -> 1 + exp(-x), 1.0)