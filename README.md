# Fortran C/C++ interoperability

Modern scientific applications require a well balanced approach to design. Many researchers are using a hybrid coding model that uses multiple programming languages. It is very common to see the core number crunching code of a scientific application being developed in Fortran, while C/C++ and even Python being used to design the driver program that handles everything else.

This repository contains example codes showing interoperability between C/C++ and Fortran.

# Code

```
 - BASICS
   '
   '- interop-1-1 : Call Fortran subroutine from C.
   '- interop-1-2 : Call C void function from Fortran.
   '
   '- interop-2-1 : Send integer and double digits to Fortran subroutine from C.
   '- interop-2-2 : Send integer and double digits to C void function from Fortran.
   '
   '- interop-3-1 : Send integer and double array to Fortran subroutine from C.
   '- interop-3-2 : Send integer and double array to C void function from Fortran.
```



