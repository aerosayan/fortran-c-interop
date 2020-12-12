subroutine sum_int(a,b)
    ! We will use the c_int type inside iso_c_binding to get a compatible
    ! integer type that lets fortran know the passed values are C integers.
    use iso_c_binding, only : c_int
    implicit none
    ! By default, all arguments passed to a fortran subroutine/function, are
    ! passed in as pointer. However, in C, we have declared the subroutine sum
    ! as void sum_(int a, int b), and not as void sum_(int *a, int *b).
    ! Thus, we need to let fortran know that the arguments a,b are being
    ! passed as values and not pointers.
    !
    ! Using the `value` keyword as shown below, fortran makes a local copy
    ! of a and b, and thus they're effectively passed by value.
    !
    integer(c_int), value :: a, b

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: SUM_INT(A,B)"
    print *, "     '- A       :=", a
    print *, "     '- B       :=", b
    print *, "     '- A+B     :=", a+b

end subroutine

! We can also do it for other numerical data types.
! Here I'm showing how do pass double values from C to Fortran.
! Look up iso_c_binding for other data types.
!
subroutine sum_double(a,b)
    use iso_c_binding, only : c_double
    implicit none
    real(c_double), value :: a, b

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: SUM_DOUBLE(A,B)"
    print *, "     '- A       :=", a
    print *, "     '- B       :=", b
    print *, "     '- A+B     :=", a+b

end subroutine
