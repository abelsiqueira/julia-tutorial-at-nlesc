# This file was generated, do not modify it. # hide
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