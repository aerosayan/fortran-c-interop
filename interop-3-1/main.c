// AIM - Show how to pass a mutable array to fortran, modify it in fortran.
//       Then we verify if the array was indeed modified in fortran.

// NOTE - In the previous codes, we have shown how to pass integers and doubles
//        between fortran and c. We simply used the datatypes defined in
//        fortran's iso_c_binding module. It's really easy.
//
//        Since this example is a little bit complicated, we will only be
//        showing how to pass a mutable integer array to fortran for now.
//
//        In future, we may add examples using mutable float/double arrays.

#include <stdio.h>
#include <stdlib.h>

void sum_array_int_(int * arr, int x, int n);

int main()
{
    // No. to be added to each element of the array
    int x = 1;
    // No. of elements in the array
    int n = 5;

    // Dynamic array
    int *arr = (int*)malloc(n*sizeof(int));

    // Insert elements into dynamic array
    for(int i=0; i<n; ++i)
    {
        arr[i] = i;
    }

    // Call fortran code to add x to each element of the array
    // We pass the address to the first element of the array, along with n.
    sum_array_int_(&arr[0], x, n);

    // Verify visually if each element in the static array was modified
    printf(" - RETURNING TO C FUNCTION...\n");
    printf("   '- FUNCTION   :: int main()\n");
    printf("      '- ARR     :=");
    for(int i=0; i<n; ++i)
    {
        printf("           %d", arr[i]);
    }
    printf("\n");

    // Scrub clean
    free(arr);

    return 0;
}
