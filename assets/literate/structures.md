<!--This file was generated, do not modify it.-->
Julia doesn't have classes, nor inheritance.
In fact, you can only derive a type from an abstract type.

```julia:ex1
struct MyComplex <: Number
  real :: Real
  img :: Real
end
```

```julia:ex2
MyComplex(1, 2.0)
```

- Notice that `real` and `img` don't need to be the same type. This can be considered a bug.
- We can parametrize the struct.

```julia:ex3
struct MyComplexT{T <: Real} <: Number
  real :: T
  img :: T
end

MyComplexT{Int}(2, 3), MyComplexT{Float64}(2, 3)
```

- If possible, the type is inferred

```julia:ex4
MyComplexT(2, 3)
```

- But remember that there is not automatic conversion

```julia:ex5
MyComplexT(2, 3.0)
```

- We can define functions with the same name as the type, which work as contructors:

```julia:ex6
MyComplexT(x :: Real) = MyComplexT(x, zero(x))

MyComplexT(1.0)
```

- The basic operations can be imported and extended for our type:

```julia:ex7
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
```

---

## Exercises

1. Import `Base.*` and implement the product of two `MyComplexT` numbers as well as the product of one real number and a complex number.

