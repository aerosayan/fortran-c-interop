// AIM - Show how to pass a C struct to fortran.
//       Show how to pass a dynamic integer array from C to fortran using c struct.


//Select the data type for the array passed to fortran
//Make sure that the correct data type of either int or double is used
//Uncomment the datatype that you would like to use
//
#define TYPE double
//#define TYPE int

#include <stdio.h>
#include <stdlib.h>

struct blah
{
    int  n;
    TYPE* array;
};

void send_cstruct_to_fortran_(struct blah* s);

int main()
{
    // No. of elements in the array
    int n = 5;

    // Dynamic array
    TYPE* array = (TYPE*)malloc(n*sizeof(TYPE));

    // Insert elements into dynamic array
    for(int i=0; i<n; ++i)
    {
        array[i] = (TYPE)i;
    }

    // Create object of struct
    struct blah s;

    // Store the first array length into struct
    s.n = n;
    s.array = array;

    // Send c struct to fortran, along with packaged data
    send_cstruct_to_fortran_(&s);

    // Scrub clean
    free(array);

    return 0;
}
