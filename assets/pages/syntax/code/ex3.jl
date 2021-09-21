# This file was generated, do not modify it. # hide
A = randn(50, 50)
b = A * ones(50)
x = A \ b
using LinearAlgebra
norm(b - A * x)
norm(x .- 1)