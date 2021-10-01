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

