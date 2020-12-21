// AIM - Show how to use memory allocated in c, for fortran allocatable arrays
//       Show how to package these allocatable arrays inside derived types.

#include <stdio.h>
#include <stdlib.h>

// We're using global variables to make the demostration simpler
int* array;
int* matrix;

// Call from fortran to get the array
int* get_array_from_c(){return array;}
// Call from fortran to get the matrix
int* get_matrix_from_c(){return matrix;}

// Call fortran subroutine and send our data
//
// If you notice carefully, we don't need to send the array and matrix
// by this method. We can define functions like get_array_from_c and
// get_matrix_from_c to get whatever data we need from c.
//
// If you notice more carefully, we don't need to define a separate function
// for separate arrays/matrices/tensors. We can store the array pointers in
// a long array, and use an integer index to access them.
//
// For example : flux_array = get_array(FLUX_ARRAY_INDEX);
//
// Where, FLUX_ARRAY_INDEX is an integer index,
// and get_array will be defined as get_array(int index){return data[index];}
//
void call_fortran_(int* array, int* matrix, int n);

int main()
{
    // No. of elements in the array
    int n = 5;

    // Dynamic array
    array = (int*)malloc(n*sizeof(int));
    // Dynamic matrix
    matrix = (int*)malloc(n*n*sizeof(int));

    // Insert elements into dynamic array
    for(int i=0; i<n; ++i)
    {
        array[i] = i;
    }
    // Inser elements into dynamic matrix
    for(int i=0; i<n*n; ++i)
    {
        matrix[i] = i;
    }

    // Send array, matrix to fortran
    call_fortran_(array, matrix, n);

    // Scrub clean
    free(array);
    free(matrix);

    return 0;
}
