subroutine sum_array_int(arr, x, n)
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
    integer(c_int), intent(inout) :: arr(n)
    ! The arguments X and N are passed by value
    integer(c_int), value :: x , n

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: SUM_ARRAY_INT(ARR,X, N)"
    print *, "     '- ARR     :=", arr
    print *, "     '- X       :=", x
    print *, "     '- N       :=", n
    print *, "     '- ARR MODIFIED AS :: ARR(:) = ARR + X"
    arr(:) = arr + x
    print *, "     '- ARR     :=", arr
    print *, "- FORTRAN SUBROUTINE FINISHED..."
end subroutine
