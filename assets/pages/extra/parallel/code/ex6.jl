# This file was generated, do not modify it. # hide
using BenchmarkTools

println("π ≈ $(calc_pi(10^7))")
@benchmark calc_pi(10^7)