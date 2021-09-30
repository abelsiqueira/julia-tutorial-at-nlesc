# This file was generated, do not modify it. # hide
using Random

function calc_pi_threaded(N)
  M = zeros(Int, nthreads())
  @threads for i = 1:N
    rng = Random.THREAD_RNGs[threadid()]
    x, y = rand(rng), rand(rng)
    if x^2 + y^2 < 1
      M[threadid()] += 1
    end
  end
  return 4 * sum(M) / N
end

println("π ≈ $(calc_pi_threaded(10^7))")
@benchmark calc_pi_threaded(10^7)