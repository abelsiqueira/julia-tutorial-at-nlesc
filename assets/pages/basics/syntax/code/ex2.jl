# This file was generated, do not modify it. # hide
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