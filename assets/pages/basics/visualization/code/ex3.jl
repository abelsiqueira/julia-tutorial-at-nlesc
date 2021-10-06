# This file was generated, do not modify it. # hide
θg = range(0, 2π, length=120)
anim = Animation()
n = 3
plot(leg=false, axis=false, grid=false, size=(600,600))
for i = 1:6
  θr = range(0, 2π, length=n + 1)
  plot!(cos.(θr), sin.(θr), c=:blue, opacity=0.5, lw=3)
  radius = 1 / cos(π / n)
  plot!(radius * cos.(θr .+ π / n), radius * sin.(θr .+ π / n), c=:red, opacity=0.5, lw=3)
  xlims!(-2, 2)
  ylims!(-2, 2)
  frame(anim)
  global n = 2n
end

gif(anim, joinpath(@OUTPUT, "vis-plots-anim-1.gif"), fps=1)