// AIM - Show how to pass a mutable matrix to fortran, modify it in fortran.
//       Then we verify if the matrix was indeed modified in fortran.

// NOTE - In the previous codes, we have shown how to pass integers and doubles
//        between fortran and c. We simply used the datatypes defined in
//        fortran's iso_c_binding module. It's really easy.
//
//        Since this example is a little bit complicated, we will only be
//        showing how to pass a mutable integer matrix to fortran for now.
//
//        In future, we may add examples using mutable float/double matrices.

#include <stdio.h>
#include <stdlib.h>

void sum_matrix_int_(int * mat, int x, int ncol_elems, int nrow_elems);

int main()
{
    // No. to be added to each element of the matrix
    int x = 1;
    // No. of elements in the rows and columns of the matrix
    int nrow_elems = 2, ncol_elems = 4;

    // Dynamic matrix
    // NOTE : Matrices in fortran are actually allocated as a single array.
    //        This allows very fast computations when the matrix size is small
    //        or large.
    //
    //        In C++, std::vector<std::vector<TYPE>> is sometimes commonly used
    //        as a makeshift matrix. However, it is a very bad idea to do so.
    //
    //        In C++, each std::vector<TYPE> is guaranteed to have all of its
    //        elements in a contiguous chunk of memory.
    //
    //        However, when we try to use std::vector<std::vector<TYPE>>, the
    //        internal std::vector<TYPE> is guaranteed to have all of its
    //        elements in a contiguous chunk of memory. Think of these internal
    //        std::vectors as rows. However, all of the rows are NOT guaranteed
    //        to be organized one after another in a contiguous chunk of memory
    //
    //        This is a bad idea because if all of the rows are not ordered in
    //        a contiguous chunk of memory, we will have severe cache misses
    //        for small matrices.
    //
    //        Thus it makes sense to organize all of the data in a matrix, in
    //        a single contiguous memory block of size nrow_elems*ncol_elems.
    //
    //        Where,
    //             nrow_elems := No. of elements in the rows of the matrix
    //             nrow_elems := No. of elements in the cols of the matrix
    //
    //        This is what Fortran does.
    //
    //        In Fortran, the elements are stored in a column wise format.
    //        i.e, MATRIX = [COLUMN 1][COLUMN 2][COLUMN 3]...[COLUMN N]
    //
    //        Thus, we reserve memory for the matrix as a 1D contiguous block.
    //        The contiguous block has space for nrow_elems*ncol_elems elements.
    //
    int *mat = (int*)malloc(nrow_elems*ncol_elems*sizeof(int));

    // Insert elements into dynamic matrix
    for(int i=0; i<nrow_elems*ncol_elems; ++i)
    {
        mat[i] = i;
    }

    // Call fortran code to add x to each element of the matrix
    // We pass the address to the first element of the matrix,
    // along with values of nrow_elems and ncol_elems.
    //
    sum_matrix_int_(&mat[0], x, ncol_elems, nrow_elems);

    // Verify visually if each element in the static array was modified
    printf(" - RETURNING TO C FUNCTION...\n");
    printf("   '- FUNCTION   :: int main()\n");
    printf("      '- MAT          :=");
    for(int i=0; i<nrow_elems*ncol_elems; ++i)
    {
        printf("           %d", mat[i]);
    }
    printf("\n");

    // Scrub clean
    free(mat);

    return 0;
}
