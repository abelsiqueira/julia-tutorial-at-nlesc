# This file was generated, do not modify it.

struct MyComplex <: Number
  real :: Real
  img :: Real
end

MyComplex(1, 2.0)

struct MyComplexT{T <: Real} <: Number
  real :: T
  img :: T
end

MyComplexT{Int}(2, 3), MyComplexT{Float64}(2, 3)

MyComplexT(2, 3)

MyComplexT(2, 3.0)

MyComplexT(x :: Real) = MyComplexT(x, zero(x))

MyComplexT(1.0)

import Base.+
function +(z1 :: MyComplexT{T}, z2 :: MyComplexT{T}) where {T}
  return MyComplexT{T}(z1.real + z2.real, z1.img + z2.img)
end

z1 = MyComplexT(1.0, 2.0)
z2 = MyComplexT(-3.0, 3.0)
z1 + z2
+(z1 :: MyComplexT{T}, x :: Real) where {T} = z1 + MyComplexT(x)
+(x :: Real, z1 :: MyComplexT{T}) where {T} = z1 + MyComplexT(x)
z1 + 3.0

