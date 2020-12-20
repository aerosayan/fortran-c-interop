// AIM - Show how to pass a C struct to fortran


#include <stdio.h>
#include <stdlib.h>

struct blah
{
    int  len_array1; // We will use only one, but you could use all of them.
    int  len_array2;
    int  len_array3;
    int  len_array4;
};

void send_cstruct_to_fortran_(struct blah* s, int* array);

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
    // We don't care about the rest for now...
    s.len_array1 = n;


    // Send c struct to fortran, along with packaged data
    send_cstruct_to_fortran_(&s, array);

    // Scrub clean
    free(array);

    return 0;
}
