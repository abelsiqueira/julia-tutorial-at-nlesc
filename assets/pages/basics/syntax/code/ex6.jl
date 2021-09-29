# This file was generated, do not modify it. # hide
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