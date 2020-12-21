// AIM - Show how to pass a C struct to fortran.
//       Show how to pass a dynamic integer array from C to fortran using c struct.


#include <stdio.h>
#include <stdlib.h>

struct blah
{
    int  n;
    int* array;
};

void send_cstruct_to_fortran_(struct blah* s);

int main()
{
    // No. of elements in the array
    int n = 5;

    // Dynamic array
    int* array = (int*)malloc(n*sizeof(int));

    // Insert elements into dynamic array
    for(int i=0; i<n; ++i)
    {
        array[i] = i;
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
