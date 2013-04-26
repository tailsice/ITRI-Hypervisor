#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <time.h>
#include <ctype.h>
int main()
{
	int i,j;
	for(i=0;;)
     {
     int k=1024,m=1024,g=40;
     int *ptr = (int *)malloc(((k*m*g))*sizeof(int));
     free(ptr); 
     }
}
