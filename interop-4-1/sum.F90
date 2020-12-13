subroutine sum_matrix_int(mat, x, ncol_elems, nrow_elems)
    use iso_c_binding, only : c_int
    implicit none
    ! The argument ARR is passed by reference.
    ! We want to modify the values inside ARR and return it.
    ! Thus intent(inout) is used.
    !
    ! NOTE : Since we know the length of the array ARR (i.e N), we let the
    !        compiler know that by defining it as ARR(N), as shown below.
    !
    !        This basically allows us to pass both dynamic arrays and static
    !        arrays to this function. This will be very useful for us.
    !
    integer(c_int), intent(inout) :: mat(ncol_elems, nrow_elems)
    ! The arguments X, N, NCOL_ELEMS, NROW_ELEMS are passed by value
    integer(c_int), value :: x , ncol_elems, nrow_elems
    integer(4) :: i, j

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: SUM_MATRIX_INT(MAT, X, NCOL_ELEMS, NROW_ELEMS)"
    print *, "     '- X            :=", x
    print *, "     '- NCOL_ELEMS   :=", ncol_elems
    print *, "     '- NROW_ELEMS   :=", nrow_elems
    print *, "     '- MAT          :=", mat

    print *, "     '  '"

    ! We print the elements of each column and also the memory address
    ! Using the memory address, we can verify if the data was modified
    do i=1,nrow_elems
    print *, "     '  '- COL ELEMS        :"
    do j=1,ncol_elems
    print *, "     '     '-->              ", mat(j,i), " | LOCATION       : ", loc(mat(j,i))
    end do
    end do

    print *, "     '"

    print *, "     '- MAT MODIFIED AS :: MAT(:,:) = MAT + X"
    mat(:,:) = mat + x

    print *, "     '- MAT          :=", mat
    print *, "     '  '"

    ! We print the elements of each column and also the memory address
    ! Using the memory address, we can verify if the data was modified
    do i=1,nrow_elems
    print *, "     '  '- COL ELEMS        :"
    do j=1,ncol_elems
    print *, "     '     '-->              ", mat(j,i), " | LOCATION       : ", loc(mat(j,i))
    end do
    end do

    print *, "- FORTRAN SUBROUTINE FINISHED..."
end subroutine
