#include <stdio.h>

void sum_int_c(int a, int b)
{
    printf(" - C FUNCTION CALLED...\n");
    printf("   '- FUNCTION :: void sum_int_c(a,b)\n");
    printf("   '- A        := %d\n", a);
    printf("   '- B        := %d\n", b);
    printf("   '- A+B      := %d\n", a+b);
}

void sum_double_c(double a, double b)
{
    printf(" - C FUNCTION CALLED...\n");
    printf("   '- FUNCTION :: void sum_double_c(a,b)\n");
    printf("   '- A        := %f\n", a);
    printf("   '- B        := %f\n", b);
    printf("   '- A+B      := %f\n", a+b);
}
