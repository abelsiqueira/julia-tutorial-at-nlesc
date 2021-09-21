#=

Julia is great because you don't have to specify types in many situations, but also, if you need or want, you can specify the types and they will be enforced.
Each time a function is used, the compiler compiles a specific version for that given signature.
To provide specialized code, the compiler needs to figure out the types of everything from the types of the input.
If that is not possible, the code is said to be "type unstable", and the performance of the code is hit.

=#
function bad_relu(x)
  if x > 0
    return x
  else
    return 0
  end
end
#=
```
@code_warntype bad_relu(1.0)
```
=#
using InteractiveUtils # hide
InteractiveUtils.@code_warntype bad_relu(1.0) # hide
#=
You should be able to see in color in your REPL the issue with this function (`::Union{Float64, Int64}`).
The compiler can't determine the type of the output given an output of type `Float64`.
If `x` is positive, then the return is of type `Float64`. Otherwise, the type will be an `Int`.

Figuring out whether there are type instabilities and fixing them are one of the main difficulties of Julia.
It is also one of the main reasons that the compiler is always being improved.
=#