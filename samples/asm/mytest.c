// test coded written by Justin.Zhao
#include <stdio.h>
#include <string.h>

//Check the data CRC sum and copy to destination
//Return 1 if everything is right, else return 0
char check_copy(char *pSrc, char *pDest, char *pSum, int len)
{
//    asm volatile("add %0, %0, #1" : "+r" (len));
//    printf("len=%d\r\n", len);
    asm(
    "add %0, %0, #1\n\t"
    "add %0, %0, #1\n\t"
    : "+r" (len)
    );

    printf("len=%d\r\n", len);
}

int main(int argc, char *argv[])
{
    int i, len;
    char src[128], dest[128];

    strcpy(src, "Hello,World!");
    len = 1;

    check_copy(src, dest, NULL, len);
    printf("src=%s, dest=%s\r\n", src, dest);

	if(argc > 1)
	{
		for(i=0;i<argc;i++)
			printf("argv[%d]=%s\r\n", i, argv[i]);
		return -1;
	}

	return 0;
}
