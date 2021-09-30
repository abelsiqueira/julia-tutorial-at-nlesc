# This file was generated, do not modify it. # hide
using Base.Threads: @threads, threadid, nthreads

function calc_pi_threaded_naive(N)
  M = zeros(Int, nthreads())
  @threads for i = 1:N
    x, y = rand(), rand()
    if x^2 + y^2 < 1
      M[threadid()] += 1
    end
  end
  return 4 * sum(M) / N
end

println("π ≈ $(calc_pi_threaded_naive(10^7))")
@benchmark calc_pi_threaded_naive(10^7)