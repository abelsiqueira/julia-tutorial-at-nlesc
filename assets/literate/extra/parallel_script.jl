# This file was generated, do not modify it.

Threads.nthreads()

using Plots # hide
pyplot() # hide
plot(leg=false, axis=false, axis_ratio=:equal, ticks=false) # hide
plot!([0,1,1,0,0], [0,0,1,1,0], c=:blue, fill=true, fillcolor=:lightblue) # hide
t = range(0, π / 2, length=100) # hide
plot!([0; cos.(t); 0], [0; sin.(t); 0], c=:red, fill=true, fillcolor=:pink) # hide
png(joinpath(@OUTPUT, "parallel-1")) # hide

function calc_pi(N)
  M = 0
  for i = 1:N
    x, y = rand(), rand()
    if x^2 + y^2 < 1
      M += 1
    end
  end
  return 4 * M / N
end

pyplot() # hide
N_values = 10 .^ (5:7)
plt = plot(layout=grid(3, 1), size=(400,600), leg=false)
for (i, N) in enumerate(N_values)
  ϵ = π .- [calc_pi(N) for _ = 1:200]
  histogram!(plt[i], ϵ, bins=20)
  title!(plt[i], "N = $N")
end
plt
png(joinpath(@OUTPUT, "parallel-2")) # hide

@time calc_pi(10^7)

using BenchmarkTools

println("π ≈ $(calc_pi(10^7))")
@benchmark calc_pi(10^7)

function calc_pi_vectorized(N)
  pts = rand(N, 2)
  M = count(sum(pts .^ 2, dims=2) .< 1)
  return 4 * M / N
end

println("π ≈ $(calc_pi_vectorized(10^7))")
@benchmark calc_pi_vectorized(10^7)

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

