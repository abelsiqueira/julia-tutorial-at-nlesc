# This file was generated, do not modify it. # hide
using LinearAlgebra, Plots, Random
pyplot()

Random.seed!(0)
n = 100
x = range(-1, 1, length=n)
y = 5 * exp.(-10x.^2) + x + 0.2 * randn(n)
Etr, Ete = Float64[], Float64[]
Ite = shuffle(1:n)[1:2 * div(n, 5)]
Itr = setdiff(1:n, Ite)
pmax = 6
plt = plot(title="ML stuff", layout=grid(1, 2), size=(800,400))
scatter!(plt[1], x, y, leg=false)
for p = 1:pmax
  X = [x[i]^j for i = 1:n, j = 0:p]
  β = X[Itr,:] \ y[Itr]
  plot!(plt[1], t -> β[1] + sum(β[j+1] * t^j for j = 1:p), -1, 1)
  r = y - X * β
  push!(Etr, norm(r[Itr])^2 / length(Itr))
  push!(Ete, norm(r[Ite])^2 / length(Ite))
end
plot!(title="MSE")
plot!(plt[2], Etr, m=(3,:blue,:square), lab="Train")
plot!(plt[2], Ete, m=(3,:red,:circle), lab="Test")
png(joinpath(@OUTPUT, "vis-plots-1"))