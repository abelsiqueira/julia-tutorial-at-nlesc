// File lu_solve.c
#include <stdio.h>

void lu_solve(long long n, float *LU, float *x)
{
  int i, j;
  
  for (i = 0; i < n; i++)
    for (j = 0; j < i; j++)
      x[i] -= LU[i + j * n] * x[j];

  for (i = n - 1; i >= 0; i--)
  {
    for (j = i + 1; j < n; j++)
      x[i] -= LU[i + j * n] * x[j];
    x[i] /= LU[i + i * n];
  }
}