subroutine send_cstruct_to_fortran(cstruct, array)
    use iso_c_binding, only : c_int, c_ptr
    implicit none

    ! Fortran doesn't know how the c struct is defined, So, we use bind(c) to
    ! define a user defined type to match the c struct.
    !
    type, bind(c) :: cstruct_interface
        integer(c_int) :: n1
        integer(c_int) :: n2
        integer(c_int) :: n3
        integer(c_int) :: n4
    end type

    ! The struct that has been passed from c to fortran
    type(cstruct_interface), intent(in) :: cstruct

    ! We're using the cstruct%n1 to define the array length, thus not needing
    ! to pass the size of every array/matrix/tensor with every function call.
    !
    ! It's not perfect since we can't pass allocatable arrays inside structs.
    ! Thus, we have to pass them as subroutine/function arguments.
    !
    integer(4), intent(in) :: array(cstruct%n1)

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: SEND_CSTRUCT_TO_FORTRAN(CSTRUCT)"
    print *, "  '- CSTRUCT%N1        : ", cstruct%n1
    print *, "  '- ARRAY             : ", array
    print *, "- FORTRAN SUBROUTINE FINISHED..."

end subroutine
