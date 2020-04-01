// test coded written by Justin.Zhao
#include <stdio.h>
#include <string.h>

//Check the data CRC sum and copy to destination
//Return 1 if everything is right, else return 0
char check_copy(char *pSrc, char *pDest, unsigned int *pSum, int len)
{
//    asm volatile("add %0, %0, #1" : "+r" (len));
//    printf("len=%d\r\n", len);
    asm(
    "mov x10, %x0 \n\t"  //Source address
    "mov x11, %x1 \n\t"  //Destination address
    "mov w12, %w2 \n\t"  //Length
    "mov w13, #0x00 \n\t" //CRC result

    "1: \n\t"
    "ldr w14, [x10] \n\t"
    "mov w15, w13 \n\t"
    "crc32w w13, w15, w14 \n\t"
    "str w14, [x11] \n\t"
    "add x10, x10, #0x04 \n\t"
    "add x11, x11, #0x04 \n\t"
    "sub w12, w12, #0x04 \n\t"
    "cbnz w12, 1b \n\t"

    "str w13, [%3] \n\t"
    : : "r" (pSrc), "r" (pDest), "r" (len), "r" (pSum)
    );

    //printf("len=%d\r\n", len);
    return 1;
}

int main(int argc, char *argv[])
{
    int i, len;
    unsigned int sum;
    char src[128], dest[128];

    strcpy(src, "Hello,World!");
    len = 32;

    check_copy(src, dest, &sum, len);
    printf("src=%s, dest=%s, sum=0x%x, srcaddr=0x0%x\r\n", src, dest, sum, src);

	if(argc > 1)
	{
		for(i=0;i<argc;i++)
			printf("argv[%d]=%s\r\n", i, argv[i]);
		return -1;
	}

	return 0;
}
