#include "header.h"
int delay_time = 10000000;

//Flashes the first 4 LEDs right to left
int right_to_left(void)
{
    my_LED = 1;

    while (1)
    {
    	my_LED *= 2;
    	for (int i = 0; i < delay_time; i++);
    	my_LED *= 2;
    	for (int i = 0; i < delay_time; i++);
    	my_LED *= 2;
    	for (int i = 0; i < delay_time; i++);
    	my_LED *= 2;
    	for (int i = 0; i < delay_time; i++);
    	my_LED = 1;
    	for (int i = 0; i < delay_time; i++);
    }
    return 0;
}

//Flashes the first 4 LEDs left to right
int left_to_right(void)
{
	my_LED = 16;

    while (1)
    {
    	my_LED /= 2;
    	for (int i = 0; i < delay_time; i++);
    	my_LED /= 2;
    	for (int i = 0; i < delay_time; i++);
    	my_LED /= 2;
    	for (int i = 0; i < delay_time; i++);
    	my_LED = 1;
    	for (int i = 0; i < delay_time; i++);
    	my_LED = 16;
    	for (int i = 0; i < delay_time; i++);
    }
}


//Flashes the first 4 LEDs right to left, and then back
int back_and_forth(void)
{
	my_LED = 1;
	while (1)
	{
		for (int j = 0; j < 3; j++)  //right to left
		{
			my_LED *= 2;
			for (int i = 0; i < delay_time; i++);
		}

		for (int j = 0; j < 3; j++)  //right to left
		{
			my_LED /= 2;
			for (int i = 0; i < delay_time; i++);
		}
	}
	return 0;
}

//displays 0-15 in binary on the LEDs
int bin_counting(void)
{
	my_LED = 0;
	while (1)
	{
		for (int j = 0; j < 16; j++)
		{
			my_LED = my_LED + 1;
			for (int i = 0; i < (delay_time * 10); i++);
		}
	}
	return 0;
}
