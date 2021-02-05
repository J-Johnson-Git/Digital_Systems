#include "header.h"

//Returns the current state of the LEDs
uint32_t read_myLED(void)
{
	uint32_t val = 0;
	val = my_LED & 0xF;
	return val;
}

//Write a value to the LEDs
void write_LED(uint32_t to_write)
{
	my_LED = to_write;
}

//Turn on LED 0, 1, 2, 3 by themselves by passing 0, 1, 2, or 3 to this function
void indiv_LED(uint32_t to_write)
{
	switch (to_write)
	{
		case 0: my_LED = 1; break;
		case 1: my_LED = 2; break;
		case 2: my_LED = 4; break;
		case 3: my_LED = 8; break;
		default: my_LED = 0;
	}
}
