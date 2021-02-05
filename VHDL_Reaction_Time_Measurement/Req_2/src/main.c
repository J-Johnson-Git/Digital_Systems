#include <stdio.h>
#include <stdlib.h>
#include "xil_io.h"
#include "xil_printf.h"

typedef uint32_t* addr;
typedef uint32_t data;

const addr rand_num_addr = (addr) 0x40000000;
const addr gen_num_addr = (addr) 0x40000004;

int main (void)
{
	data rand_num = 0;
	data rst = 0;
	while (1)
	{
		rst = *(gen_num_addr);
		if (rst)
		{
			rand_num = rand() % 10 + 1;
			*(rand_num_addr) = rand_num;
		}
	}
	return 0;
}
