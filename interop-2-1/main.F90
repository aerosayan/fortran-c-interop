! AIM : Call C void function from Fortran

! A little bit different from interop-1-1, the gcc compiler will not add
! an underscore to the end of the function hello_c -> hello_c_.
!
! Thus, it is necessary that the user add the underscore to the end of the
! function name hello_c. This is done in the file hello.c
!
! This is required because we're linking all of the object files into a final
! executable using gfortran. And as we know from interop-1-1, gfortran adds
! underscores to end of fortran subroutines, thus it expects these underscores
! to be present while linking.
!
program main
call hello_c()
end program
