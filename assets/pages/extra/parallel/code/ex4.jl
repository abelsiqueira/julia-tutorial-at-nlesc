# This file was generated, do not modify it. # hide
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