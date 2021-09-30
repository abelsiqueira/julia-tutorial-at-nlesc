# This file was generated, do not modify it. # hide
function calc_pi(N)
  M = 0
  for i = 1:N
    x, y = rand(), rand()
    if x^2 + y^2 < 1
      M += 1
    end
  end
  return 4 * M / N
end