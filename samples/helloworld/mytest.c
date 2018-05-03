// test coded written by Justin.Zhao
#include <stdio.h>
#include <thread>
#include <iostream>
#include <unistd.h>

void foo(int index)
{
	std::cout << "Hello, World! index=" << index << std::endl;
	sleep(5);
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


	std::thread t0(foo, 0);
	std::thread t1(foo, 1);

    for(i=0; i<5; i++)
        printf("Justin.Zhao: test %d\r\n", i);

	t0.join();
	t1.join();
	std::cout << "End!" << std::endl;

	return 0;
}
