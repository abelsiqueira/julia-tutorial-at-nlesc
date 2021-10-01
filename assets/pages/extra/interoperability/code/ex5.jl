# This file was generated, do not modify it. # hide
using Plots, PyCall, Random
pyplot()

Random.seed!(123)
n = 2^8
X = (2 * rand(n, 2) .- 1) * 4
y = [
  X[i,2]^2 * 16 - X[i,1]^2 * 16 ≤ 2 * randn() ? 1 : -1 for i = 1:n
]
y = [
  (X[i,1] - 1)^2 + (4 - randn()) * (X[i,2] - X[i,1]^2)^2 ≤ 10 ? 1 : -1 for i = 1:n
]
plot(leg=false)
idx = findall(y .== -1)
scatter!(X[idx,1], X[idx,2], m=(4,:red,:square))
idx = findall(y .== 1)
scatter!(X[idx,1], X[idx,2], m=(4,:blue,:circle))
png(joinpath(@OUTPUT, "pycall-1")) # hide