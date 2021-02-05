#include "header.h"
int delay_time = 10000000;  //global def of delay amount

void enable(uint32_t en, uint32_t val)
{
	en_LED = en;

	while (1)
	{
		my_LED = val;
		for (int i = 0; i < delay_time; i++);
	}
}

