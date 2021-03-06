# Fortran C/C++ interoperability

Modern scientific applications require a well balanced approach to design. Many researchers are using a hybrid coding model that uses multiple programming languages. It is very common to see the core number crunching code of a scientific application being developed in Fortran, while C/C++ and even Python being used to design the driver program that handles everything else.

This repository contains example codes showing interoperability between C/C++ and Fortran.

_work in progress_ ...

# Code

```
 - BASIC
   '
   '- interop-0-1 : extern "C"
   '
   '- interop-1-1 : Call Fortran subroutine from C.
   '- interop-1-2 : Call C void function from Fortran.
   '
   '- interop-2-1 : Send integer and double digits to Fortran subroutine from C.
   '- interop-2-2 : Send integer and double digits to C void function from Fortran.

 - INTERMEDIATE
   '
   '- interop-3-1 : Send dynamic integer array to Fortran subroutine from C.
   '
   '- interop-4-1 : Send dynamic integer matrix to Fortran subroutine from C.
   '
   '- interop-5-1 : Send C struct to Fortran subroutine from C.
   '- interop-5-2 : Send C struct containing dynamic integer array to Fortran subroutine from C.
   '
   '- interop-6-1 : i.   Send dynamic integer array and matrix to Fortran subroutine from C.
                    ii.  Use c_f_pointer in Fortran to access integer array and matrix allocated in C.
                    iii. Store received data inside a derived type for better encapsulation.

 - PERFORMANCE
   '- perf-interop-5-2 : Performance analysis of interop-5-2 by observing the
                         generated assembly for arrays of integer and double
                         type and verifying if MAVX2 optimizations
                         was possible.
```
# How to run code

Makefiles are provided along with the expected output in file output.txt.

Go to any directory, run make command to produce the executable `a.out`, then run the executable `a.out`.

```
$ cd interop-4-1
$ make
$ ./a.out
```
