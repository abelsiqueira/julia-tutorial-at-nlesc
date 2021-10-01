# This file was generated, do not modify it. # hide
function mydft(x)
  n = length(x)
  return [
    sum(x[i+1] * exp(-im * 2π * i * k / n) for i = 0:n-1)
    for k = 0:n-1
  ]
end
mydft(x)