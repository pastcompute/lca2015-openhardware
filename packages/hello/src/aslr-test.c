/*
 * Contrast compiling with:
 *   gcc -o aslr-test-withpie -fPIC -pie aslr-test.c
 *   gcc -o aslr-test-without -fno-PIC -nopie aslr-test.c
 *
 */
  
#include <stdio.h>
  
void doit()
{
        ;
        return ;
}
  
int main()
{
        printf("main @ %p\n", main);
        printf("doit @ %p\n", doit);
        return 0;
}
