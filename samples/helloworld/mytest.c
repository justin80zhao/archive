// test coded written by Justin.Zhao
#include <stdio.h>
#include <thread>
#include <iostream>

void foo()
{
	std::cout << "Hello, World!" << std::endl;
}

int main(int argc, char *argv[])
{
    int i;

	if(argc > 1)
	{
		for(i=0;i<argc;i++)
			printf("argv[%d]=%s\r\n", i, argv[i]);
		return -1;
	}

    for(i=0; i<5; i++)
        printf("Justin.Zhao: test %d\r\n", i);

	std::thread t(foo);
	t.join();

	return 0;
}
