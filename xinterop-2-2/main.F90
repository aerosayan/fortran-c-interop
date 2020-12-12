! Module that contains all of our interfaces to C functions
module my_interfaces_mod

! We need to create an interface to C functions when we want to pass complicated
! data types as arguments. Interfaces have some really amazing features.
! Using the bind(c, name="...") feature, we will call the C functions sum_int_c
! and sum_double_c by renaming them to sum_int_fortran, sum_double_fortran
! respectively.
!
! This shows that even if the C functions have weird names, we can
! call them using our own preferred name in fortran.
!
! However, this is not the main reason it is helpful.
! This bind=".." feature is helpful in most cases due to being able to call the
! C functions without needing to add an underscore to the function name and
! without recompiling it.
!
! Defining interfaces are relatively easy, even if they look complicated.
! We just need to tell the compiler what are the data types of the arguments.
! And how the function signature looks.
!
interface my_interface_to_c

    subroutine sum_int_fortran(a,b) bind(c, name="sum_int_c")
    use iso_c_binding, only : c_int
    implicit none
    integer(c_int), value :: a, b
    end subroutine

    subroutine sum_double_fortran(a,b) bind(c, name="sum_double_c")
    use iso_c_binding, only : c_double
    implicit none
    real(c_double), value :: a, b
    end subroutine

end interface
end module

program main
! Use the interfaces defined in the module my_interfaces_mod
use my_interfaces_mod
implicit none

call sum_int_fortran(1,9)
call sum_double_fortran(1.0001d0, 9.0001d0)

end program


