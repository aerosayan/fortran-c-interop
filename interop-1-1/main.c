// AIM : Call a fortran subroutine from C

// The C compiler doesn't know the subroutine hello_fortran exists
// Thus, it is necessary to include a  declaration.
// Since the subroutine will not return anything, we will define it as a
// function in C with return type void.
//
// Even though the subroutine name is hello_fortran, the gfortran compiler will
// add an underscore to the end of the subroutine name and reaname it as
// hello_fortran -> hello_fortran_
//
// Thus, the C compiler will only be able to see a subroutine hello_fortran_
// while linking.
void hello_fortran_();

int main()
{
    // Call fortran subroutine hello_fortran
    hello_fortran_();

    return 0;
}
