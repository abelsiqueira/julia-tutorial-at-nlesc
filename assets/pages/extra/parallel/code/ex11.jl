# This file was generated, do not modify it. # hide
using FLoops

function calc_pi_proper_floop(N)
  ranges = splitrange(1, N, nthreads())
  @floop for rg in ranges
    rng = MersenneTwister()
    c = 0
    for _ in rg
      c += rand(rng)^2 + rand(rng)^2 < 1
    end
    @reduce(M += c)
  end
  return 4 * M / N
end

println("π ≈ $(calc_pi_proper_floop(10^7))")
@benchmark calc_pi_proper_floop(10^7)