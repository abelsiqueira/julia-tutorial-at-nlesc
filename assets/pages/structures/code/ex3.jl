# This file was generated, do not modify it. # hide
struct MyComplexT{T <: Real} <: Number
  real :: T
  img :: T
end

MyComplexT{Int}(2, 3), MyComplexT{Float64}(2, 3)