# This file was generated, do not modify it. # hide
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