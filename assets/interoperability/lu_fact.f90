! File lu_fact.f90
subroutine lu_factorization (nrow, ncol, A)

  implicit none

  integer, intent(in) :: nrow, ncol
  real, intent(inout), dimension(nrow, ncol) :: A

  integer :: i, j, k

  do j = 1,nrow
    do i = j+1,nrow
      A(i,j) = A(i,j) / A(j,j)
      do k = j+1,ncol
        A(i,k) = A(i,k) - A(j,k) * A(i,j)
      enddo
    enddo
  enddo

end