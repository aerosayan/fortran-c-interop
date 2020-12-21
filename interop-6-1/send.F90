! We will package and encapsulate our data types inside a derived data type
! so that it can be sent to other fortran functions/subroutines along with
! the object of the derived type, and without needing to type many arguments
! for each function/subroutine.
!
module my_types
type data_container
    ! c_f_pointer expects a pointer to the arrays/matrices,
    ! so we have to define them as pointers.
    !
    integer(4), pointer, dimension(:)   :: encapsulated_arr
    integer(4), pointer, dimension(:,:) :: encapsulated_mat
end type
end module

subroutine call_fortran(arr, mat, n)
    use iso_c_binding, only : c_int, c_ptr, c_f_pointer
    use my_types
    implicit none

    ! Interface to our c function that returns int* array
    interface
    function get_array_from_c() bind(c, name="get_array_from_c")
        import :: c_ptr
        type(c_ptr) :: get_array_from_c
    end function
    end interface

    ! Interface to our c function that returns int* matrix
    interface
    function get_matrix_from_c() bind(c, name="get_matrix_from_c")
        import :: c_ptr
        type(c_ptr) :: get_matrix_from_c
    end function
    end interface

    ! No. of elements in the array and no. of rows,columns in the matrix
    integer(c_int), value :: n
    ! Defining the array and matrix
    ! We will print the values, then call c_f_pointer to get the array & matrix
    ! from c, and then print them to verify the transfer. We will then modify
    ! the array and matrix received from c_f_pointer, then see if we the
    ! original array and matrix were modified.
    !
    integer(c_int), intent(in) :: arr(n)
    integer(c_int), intent(in) :: mat(n,n)

    ! Derived data type to encapsulate our data
    type(data_container) :: dc

    print *, "- FORTRAN SUBROUTINE CALLED..."
    print *, "  '- SUBROUTINE :: CALL_FORTRAN(ARR, MAT, N)"
    print *, "  '- N        : ", n
    print *, "  '- ARR      : ", arr
    print *, "  '- MAT(:,1) : ", mat(:,1)
    print *, "  '- MAT(:,N) : ", mat(:,N)

    print *, "- ENCAPSULATING DATA INSIDE DERIVED TYPE..."
    ! Use c_f_pointer to call get_array_from_c and store it inside
    ! the pointer dc%encapsulated_arr which has is a single dimension
    ! array of length n.
    !
    call c_f_pointer(get_array_from_c(), dc%encapsulated_arr, [n])
    ! Do the same for the matrix
    call c_f_pointer(get_matrix_from_c(), dc%encapsulated_mat, [n,n])

    ! Print results to verify...
    print *, "  '- N        : ", n
    print *, "  '- EARR     : ", dc%encapsulated_arr
    print *, "  '- EMAT(:,1): ", dc%encapsulated_mat(:,1)
    print *, "  '- EMAT(:,N): ", dc%encapsulated_mat(:,N)

    ! Modifying the arrays through the derived type
    print *, "- ADDING ONE TO EARR, EMAT THROUGH THE DERIVED TYPE..."
    print *, "  '- OPERATION :: dc%earr(:)   = dc%earr+1"
    dc%encapsulated_arr(:) = dc%encapsulated_arr+1

    print *, "  '- OPERATION :: dc%emat(:,:) = dc%emat+1"
    dc%encapsulated_mat(:,:) = dc%encapsulated_mat+1

    print *, "- VERIFYING IF ORIGINAL ARR, MAT WERE MODIFIED..."
    print *, "  '- ARR      : ", arr
    print *, "  '- MAT(:,1) : ", mat(:,1)
    print *, "  '- MAT(:,N) : ", mat(:,N)

    print *, "- FORTRAN SUBROUTINE FINISHED..."
end subroutine
