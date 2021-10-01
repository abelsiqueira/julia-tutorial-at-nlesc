# This file was generated, do not modify it. # hide
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