#=
- Julia's arrays default to column vector behaviour
- Julia uses brackets to access elements and indices start at 1
- Slices are inclusive of endpoints, and `end` means end.
- Steps can be passed in the middle
=#
x = [1, 2, 3, 4, 5]
x * 2
ones(5) + x
x[2]
x[1:2]
x[2:end]
x[1:2:end]
length(x)
# - Matrices are first-class citizens.
# - Create with brackets, spaces change columns, and `;` change lines.
# - Only in vectors `,` can be used instead of spaces (compat. Python).
# - You can concatenate matrices, vectors and numbers with the same syntax.
A = [3 2 4; -1 0 1]
A * ones(3)
B = rand(3, 3)
A * B
B * A'
A[1:2, 1:2]
[
  B A';
  A ones(2,2)
]
# - Linear systems can be solved with `\ `
# - the LinearAlgebra stdlib module contains useful linear algebra tools, functions and elements.
A = randn(50, 50)
b = A * ones(50)
x = A \ b
using LinearAlgebra
norm(b - A * x)
norm(x .- 1)
# - Everything has a concrete type, every type derives from some abstract type.
# - There is no implicit conversion, but sometimes it looks like there is.
typeof(2)
typeof(2.0)
Float64 |> supertype
Float64 |> supertype |> supertype
typeof(2 + 2.0)
typeof([2, 2.0])
typeof([2, true])
typeof([2, "a"])
# - There are 3 ways to write functions
function foo(a, b)
  return (a + 1) * (b - 1)
end
foo(2, 3)
bar(x) = x^2 - 2
bar(5)
anon = (a, b, c) -> sqrt(a^2 + b^2 + c^2)
anon(-1, 0, 1)
# - `if CONDITION ... elseif ... else ... end`
# - `while CONDITION ... end`
# - `for VARIABLE in SET|RANGE|ITERATOR ... end`
# - You can specify types
function myfactorial(n::Int)
  if n < 0
    error("Nay nay")
  end
  prod = 1
  for i = 2:n
    prod *= i
  end
  return prod
end
myfactorial(4)
# - You can insert unicode characters with `\something[TAB]`.
function machine_eps(x::AbstractFloat)
  ϵ = x
  while x + ϵ != x
    ϵ /= 2
  end
  return 2ϵ
end
machine_eps(1.0), machine_eps(1e4), machine_eps(Float16(1.0)), machine_eps(1.0f0)
# - you can create a different signature
function machine_eps(x::Integer)
  return zero(x)
end
machine_eps(1), machine_eps(0x05), machine_eps(typemax(1))
# - you can set default positional arguments and keyword arguments
function newton(f, fder, x = 0.0; atol = 1e-6, rtol = 1e-6, max_iter = 1000)
  fx = f(x)
  iter = 0
  ϵ = atol + rtol * abs(fx)
  solved = abs(fx) < ϵ
  tired = iter ≥ max_iter
  while !(solved || tired)
    slope = fder(x)
    if abs(slope) < 1e-12
      error("0 derivative at x = $x")
    end
    x -= fx / slope
    fx = f(x)
    iter += 1
    solved = abs(fx) < ϵ
    tired = iter ≥ max_iter
  end
  return x, fx, iter
end
newton(x -> x - exp(-x), x -> 1 + exp(-x), 1.0)
# - You can use parametric types
# - The type must be inferred from somewhere, so `x` is not optional anymore
function newton_parametric(f, fder, x :: T; atol :: T = √eps(T), rtol :: T = √eps(T), max_iter :: Int = 1000) where T
  fx = f(x)
  iter = 0
  ϵ = atol + rtol * abs(fx)
  slope_ϵ = (√√eps(T))^3 # ϵₘ^(3/4)
  solved = abs(fx) < ϵ
  tired = iter ≥ max_iter
  while !(solved || tired)
    slope = fder(x)
    if abs(slope) < slope_ϵ
      error("0 derivative at x = $x")
    end
    x -= fx / slope
    fx = f(x)
    iter += 1
    solved = abs(fx) < ϵ
    tired = iter ≥ max_iter
  end
  return x, fx, iter
end
for T in [Float16, Float32, Float64, BigFloat]
  x, fx, iter = newton_parametric(x -> x^2 - 2, x -> 2x, one(T))
  println("√2 ≈ $x")
end
# - Formatted printing is possible with the `Printf` stdlib
# - `@printf` is a macro. Interpolation (`"$x"`) is not possible.
using Printf
for T in [Float16, Float32, Float64, BigFloat]
  x, fx, iter = newton_parametric(x -> x^2 - 2, x -> 2x, one(T))
  @printf("√2 ≈ %20.16e, (√2)² - 2 ≈ %20.16e\n", x, x^2 - 2)
end
# - In the REPL, `?` enters help mode.
# - `apropos` can be used to search among the docstrings
#=
---

## Exercises

1. Verify that if `v` and `w` are vectors, then `[v w]` and `[v, w]` are different. Notice the type of the second object.
1. Search for "dot product" using the `apropos` function.
1. Create a function that orthogonalizes a _list of vectors_ following the given theorem:
**Theorem**: Given $n$ linear independent vector $v_1, v_2, \dots, v_n$, define
$\displaystyle q_i = v_i - \sum_{j = 1}^{i-1} (v_i \cdot q_j) q_j, \ \forall \ i = 1,\dots,n$.
The vectors $q_1, q_2, \dots, q_n$ are orthogonal.
=#
