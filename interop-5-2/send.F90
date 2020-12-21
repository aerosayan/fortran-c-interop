subroutine send_cstruct_to_fortran(cstruct)
    use iso_c_binding, only : c_int, c_ptr, c_f_pointer
    implicit none

    ! Fortran doesn't know how the c struct is defined, So, we use bind(c) to
    ! define a user defined type to match the c struct.
    !
    type, bind(c) :: cstruct_interface
        integer(c_int) :: n
        type(c_ptr)    :: array
    end type

    ! The struct that has been passed from c to fortran
    type(cstruct_interface), intent(in) :: cstruct

    ! We want to access cstruct%array.
    ! Thus we define array_local as a pointer to an array.
    ! We then use c_f_pointer to cast the c pointer cstruct%array to a
    ! fortran compatible pointer array_local. We can then use array_local
    !
    integer(4), pointer, dimension(:) :: array_local

    call c_f_pointer(cstruct%array, array_local, [cstruct%n])

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: SEND_CSTRUCT_TO_FORTRAN(CSTRUCT)"
    print *, "  '- CSTRUCT%N    : ", cstruct%n
    print *, "  '- ARRAY_LOCAL  : ", array_local
    print *, "- FORTRAN SUBROUTINE FINISHED..."

end subroutine
