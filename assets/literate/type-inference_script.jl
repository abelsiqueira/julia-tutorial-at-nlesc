# This file was generated, do not modify it.

function bad_relu(x)
  if x > 0
    return x
  else
    return 0
  end
end

using InteractiveUtils # hide
InteractiveUtils.@code_warntype bad_relu(1.0) # hide

