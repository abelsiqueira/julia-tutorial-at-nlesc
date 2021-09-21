# This file was generated, do not modify it. # hide
function machine_eps(x::AbstractFloat)
  ϵ = x
  while x + ϵ != x
    ϵ /= 2
  end
  return 2ϵ
end
machine_eps(1.0), machine_eps(1e4), machine_eps(Float16(1.0)), machine_eps(1.0f0)