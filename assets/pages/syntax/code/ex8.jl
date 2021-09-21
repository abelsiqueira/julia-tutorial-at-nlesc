# This file was generated, do not modify it. # hide
function machine_eps(x::Integer)
  return zero(x)
end
machine_eps(1), machine_eps(0x05), machine_eps(typemax(1))