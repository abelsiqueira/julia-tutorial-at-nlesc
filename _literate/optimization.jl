#=
In this example we'll compare the optimization of a relatively simple problem: Logistic Regression.

Consider a binary classification dataset
  $\Omega = \{(x_i, y_i) \subset \mathbb{R}^p\times\{0,1\}:\ i = 1, \dots, n\}$.

The logistic regression problem defines a model
$h_{\beta}(x) = \sigma(\hat{x}^T \beta) = \sigma(\beta_0 + x^T\beta_{1:p})$,
where
$\hat{x} = \begin{bmatrix} 1 \\ x \end{bmatrix}$.
The value of $\beta$ is found by finding the maximum of the log-likelihood function
  
$$\ell(\beta) = \frac{1}{n} \sum_{i=1}^n y_i \ln \big(h_{\beta}(x_i)\big) + (1 - y_i) \ln\big(1 - h_{\beta}(x_i)\big).$$

We'll input the gradient of this function manually. It is given by

$$\nabla \ell(\beta) = \frac{1}{n} \sum_{i=1}^n \big(y_i - h_{\beta}(x_i)\big) \hat{x}_i = \frac{1}{n} \begin{bmatrix} e^T \\ X^T \end{bmatrix} (y - h_{\beta}(X)), $$

where $e$ is the vector with all components equal to 1.

Download the data.csv to follow the example.

TODO: link to data.csv

In Python, we can define the function $-\ell(\beta)$ to minimize, and its derivatives, as follows:

```python
import numpy as np
import pandas as pd
from scipy.optimize import minimize

df = pd.read_csv('data.csv')
X = df.iloc[:,0:-1].values
y = df.iloc[:,-1].values
n, p = X.shape

def sigmoid(t):
    return 1 / (1 + np.exp(-t))

def myfun(beta):
    hbeta = sigmoid(beta[0] + X.dot(beta[1:]))
    return -np.sum(
        y * np.log(hbeta + 1e-8) + (1 - y) * np.log(1 - hbeta + 1e-8)
    ) / n

def myjac(beta):
    hbeta = sigmoid(beta[0] + X.dot(beta[1:]))
    dif = hbeta - y
    return np.concatenate((np.array([np.sum(dif)]), X.T.dot(dif))) / n

beta0 = np.zeros(p + 1)
res = minimize(myfun, beta0, jac=myjac, method='l-bfgs-b', tol=1e-4)
beta = res.x
hbeta = sigmoid(beta[0] + X.dot(beta[1:]))
ypred = np.round(hbeta)
accuracy = sum(y == ypred) / n
print('accuracy = ', accuracy)
```
If you're using Jupyter, I also ask you to run
```
%%timeit
res = minimize(myfun, beta0, jac=myjac, method='l-bfgs-b', tol=1e-4)
```
So that we can compare the time

Here's a similar Julia version
=#
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

#=
The beginning of the codes is similar: read the file, create `X` and `y`.

We then define the functions. Some main differences:
- Instead of writing the objective vectorized, I use a loop over the indices.
- To avoid creating a vector for `β[2:end]`, I use `@views` at the beginning of the line. The macro automatically transforms `β[2:end]` into `view(β, 2:end)`.
- The Julia `myjac` function receives an additional argument for the memory that it should reuse (`gx`) for the output.

Now, the specific part. In Python, we use SciPy's optimize, and in Julia we're using Optim.jl.
The arguments are similar, although Optim's arguments are positional.

We can benchmark Optim's code to compare against SciPy's optimize:
=#
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
#=
In Julia, we don't have a single optimization library.
In fact, I'm co-creator of the [JuliaSmoothOptimizers](https://juliasmoothoptimizers.github.io) organization, which "competes" against Optim.
We focus on tools for Nonlinear Optimization developers, instead of focusing on users, so our basic interface is a lot more raw.
On the other hand, we claim that our methods are faster, but notice my bias.

NLPModels alone doesn't have a simple user interface, so we create a struct `MyLogisticRegression` to hold the problem and to indicate the objective and gradient.
The struct fields are not obvious and you have to follow the docs of NLPModels to learn how to do it.
But you can check the speed gain.
=#

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

# TODO: Check progress of ManualNLPModels

#=
One noteworthy aspect of this comparison is that Python uses the L-BFGS-B Fortran algorithm, which is a reference implementation of a classic method.
The Julia versions are pure Julia.
=#