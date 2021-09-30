# This file was generated, do not modify it. # hide
function calc_pi_vectorized(N)
  pts = rand(N, 2)
  M = count(sum(pts .^ 2, dims=2) .< 1)
  return 4 * M / N
end

println("π ≈ $(calc_pi_vectorized(10^7))")
@benchmark calc_pi_vectorized(10^7)