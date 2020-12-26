! Select the data type for the array passed to fortran
! Make sure that the correct data type between integer(4) or real(8) is used
! Uncomment the datatype that you would like to use
!
#define FTYPE real(8)
!#define FTYPE integer(4)

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
    ! Iterators
    integer(4) :: i

    ! We want to access cstruct%array.
    ! Thus we define array_local as a pointer to an array.
    ! We then use c_f_pointer to cast the c pointer cstruct%array to a
    ! fortran compatible pointer array_local. We can then use array_local
    !
    FTYPE, pointer, dimension(:) :: array_local

    call c_f_pointer(cstruct%array, array_local, [cstruct%n])

    ! Modify array_local to see if openmp can be used to do mavx2 vectorization
    !
    !$omp simd
    do i=1,cstruct%n
        array_local(i) = array_local(i)**2/array_local(i)+0.5*array_local(i)
    end do

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: SEND_CSTRUCT_TO_FORTRAN(CSTRUCT)"
    print *, "  '- CSTRUCT%N    : ", cstruct%n
    print *, "  '- ARRAY_LOCAL  : ", array_local
    print *, "- FORTRAN SUBROUTINE FINISHED..."

end subroutine
