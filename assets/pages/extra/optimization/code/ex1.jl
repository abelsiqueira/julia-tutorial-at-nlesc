# This file was generated, do not modify it. # hide
using ADNLPModels, CSV, DataFrames, Optim, JSOSolvers, LinearAlgebra, Logging, NLPModels

path = joinpath("assets", "python-scipy-optimize-example", "data.csv")
df = DataFrame(CSV.File(path))
X = Matrix(df[:,1:end-1])
y = df[:,end]
n, p = size(X)

sigmoid(t) = 1 / (1 + exp(-t))

function myfun(β, X, y)
  @views hβ = sigmoid.(β[1] .+ X * β[2:end])
  out = sum(
    yᵢ * log(ŷᵢ + 1e-8) + (1 - yᵢ) * log(1 - ŷᵢ + 1e-8)
    for (yᵢ, ŷᵢ) in zip(y, hβ)
  )
  return -out / length(y)
end

function myjac(out, β, X, y)
  n = length(y)
  @views δ = (sigmoid.(β[1] .+ X * β[2:end]) - y) / n
  out[1] = sum(δ)
  out[2:end] .= X' * δ
  return out
end

output = optimize(
  β -> myfun(β, X, y),
  (out, β) -> myjac(out, β, X, y),
  zeros(p + 1),
  LBFGS(),
  Optim.Options(
    g_tol = 1e-4,
  ),
)

β = Optim.minimizer(output)
hβ = sigmoid.(β[1] .+ X * β[2:end])
ŷ = round.(hβ)
accuracy = sum(y .== ŷ) / n