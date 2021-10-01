# This file was generated, do not modify it.

using Libdl, LinearAlgebra

path = "assets/interoperability"
lib = joinpath(path, "lu.so")

n = 10
L = tril(rand(Float32, n, n), -1) + I
U = triu(rand(Float32, n, n))
A = L * U
b = A * ones(Float32, n)

LU = copy(A)
x = copy(b)

ccall(
  (:lu_factorization_, lib),
  Cvoid,
  (Ref{Int}, Ref{Int}, Ref{Cfloat}),
  n, n, LU,
)

ccall(
  (:lu_solve, lib),
  Cvoid,
  (Int, Ref{Cfloat}, Ref{Cfloat}),
  n, LU, x,
)

println("‖LU - (L + U - I)‖ = ", norm(LU - L - U + I))
println("‖x - 1‖ = ", norm(x .- 1))
println("‖A * x - b‖ = ", norm(A * x - b))

function myfft(x::Vector{ComplexF64})
  y = copy(x)
  FFTW_FORWARD = Int32(-1)
  FFTW_ESTIMATE = Int32(64)

  plan = ccall(
    (:fftw_plan_dft_1d, "fftw-3.3.10/.libs/libfftw3.so"),
    Ptr{Cvoid},
    (Int32, Ref{ComplexF64}, Ref{ComplexF64}, Int32, UInt32),
    length(x), x, y, FFTW_FORWARD, FFTW_ESTIMATE
  )
  ccall(
    (:fftw_execute, "fftw-3.3.10/.libs/libfftw3.so"),
    Cvoid,
    (Ptr{Cvoid},),
    plan
  )
  ccall(
    (:fftw_destroy_plan, "fftw-3.3.10/.libs/libfftw3.so"),
    Cvoid,
    (Ptr{Cvoid},),
    plan
  )
  return y
end
#We won't build fftw online, so here's cheating: # hide
if get(ENV, "CI", "no") == "yes" # hide
  using FFTW # hide
  myfft(x) = fft(x) # hide
end # hide

x = rand(ComplexF64, 8)
y = myfft(x)

function mydft(x)
  n = length(x)
  return [
    sum(x[i+1] * exp(-im * 2π * i * k / n) for i = 0:n-1)
    for k = 0:n-1
  ]
end
mydft(x)

using FFTW
y = fft(x)

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

svm = pyimport_conda("sklearn.svm", "scikit-learn")
clf = svm.SVC(C=1e-2, gamma=5.0, probability=true)
clf.fit(X, y)
x1g = range(extrema(X[:,1])..., length=100)
x2g = range(extrema(X[:,2])..., length=100)
Z = [
  clf.predict_proba([x1i x2j;])[2] for x2j in x2g, x1i in x1g
]
contourf(x1g, x2g, Z, c=cgrad([:pink,:magenta,:lightblue]), levels=50)
idx = findall(y .== -1)
scatter!(X[idx,1], X[idx,2], m=(4,:red,:square), lab="", opacity=0.5)
idx = findall(y .== 1)
scatter!(X[idx,1], X[idx,2], m=(4,:blue,:circle), lab="", opacity=0.5)
png(joinpath(@OUTPUT, "pycall-2")) # hide

