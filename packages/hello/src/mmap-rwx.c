/*
 * Contrast compiling with:
 *   gcc -UBAD -o mmap-rw mmap-rwx.c
 *   gcc -DBAD -o mmap-rwx mmap-rwx.c
 */
  
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <errno.h>
#include <string.h>
  
int main()
{
	size_t *m;
  
#ifdef BAD
	m = mmap( NULL, 1024, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0 );
#else
	m = mmap( NULL, 4096, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0 );
#endif
  
	if( m == MAP_FAILED )
		printf("mmap failed: %s\n", strerror(errno));
	else
		printf("mmap succeeded: %p\n", m);
  	
        return 0;
}
