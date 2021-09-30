# This file was generated, do not modify it. # hide
using Distributed: splitrange

function calc_pi_proper_threaded(N)
  ranges = splitrange(1, N, nthreads())
  M = Ref(0)
  @threads for rg in ranges
    rng = MersenneTwister()
    c = 0
    for _ in rg
      c += rand(rng)^2 + rand(rng)^2 < 1
    end
    M[] += c
  end
  return 4 * M[] / N
end

println("π ≈ $(calc_pi_proper_threaded(10^7))")
@benchmark calc_pi_proper_threaded(10^7)