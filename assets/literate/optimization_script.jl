# This file was generated, do not modify it.

using CSV, DataFrames, Optim, LinearAlgebra

path = joinpath("assets", "data.csv")
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

using BenchmarkTools

β₀ = zeros(p + 1)
@benchmark optimize(
  β -> myfun(β, X, y),
  (out, β) -> myjac(out, β, X, y),
  β₀,
  LBFGS(),
  Optim.Options(
    g_tol = 1e-4,
  ),
)

using JSOSolvers, Logging, NLPModels

struct MyLogisticRegression <: AbstractNLPModel{Float64, Vector{Float64}}
  meta :: NLPModelMeta{Float64, Vector{Float64}}
  counters :: Counters
  X
  y

  function MyLogisticRegression(X, y)
    meta = NLPModelMeta(p+1, x0=zeros(p+1))
    return new(meta, Counters(), X, y)
  end
end

NLPModels.obj(nlp :: MyLogisticRegression, x) = myfun(x, nlp.X, nlp.y)
NLPModels.grad!(nlp :: MyLogisticRegression, x, gx) = myjac(gx, x, nlp.X, nlp.y)

nlp = MyLogisticRegression(X, y)
output = lbfgs(nlp, atol=1e-4, rtol=1e-4)
println(output)

@benchmark with_logger(NullLogger()) do
  lbfgs(nlp, atol=1e-4, rtol=1e-4)
end

