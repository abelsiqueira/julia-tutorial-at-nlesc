# This file was generated, do not modify it. # hide
function newton_parametric(f, fder, x :: T; atol :: T = √eps(T), rtol :: T = √eps(T), max_iter :: Int = 1000) where T
  fx = f(x)
  iter = 0
  ϵ = atol + rtol * abs(fx)
  slope_ϵ = (√√eps(T))^3 # ϵₘ^(3/4)
  solved = abs(fx) < ϵ
  tired = iter ≥ max_iter
  while !(solved || tired)
    slope = fder(x)
    if abs(slope) < slope_ϵ
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
for T in [Float16, Float32, Float64, BigFloat]
  x, fx, iter = newton_parametric(x -> x^2 - 2, x -> 2x, one(T))
  println("√2 ≈ $x")
end