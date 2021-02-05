#include "header.h"

//Set duty cycle for LD0
void setled0_dc(data val)
{
	if (val < 1024)  //max DC val is 2^10 (10-bit number only availble in hardware)
	{
		*(led0_dc) = val;  //*(address) = val;
	}
}

//Set duty cycle for LD1
void setled1_dc(data val)
{
	if (val < 1024)  //max DC val is 2^10 (10-bit number only availble in hardware)
	{
		*(led1_dc) = val;  //*(address) = val;
	}
}

//Set duty cycle for LD2
void setled2_dc(data val)
{
	if (val < 1024)  //max DC val is 2^10 (10-bit number only availble in hardware)
	{
		*(led2_dc) = val;  //*(address) = val;
	}
}

//Set duty cycle for LD3
void setled3_dc(data val)
{
	if (val < 1024)  //max DC val is 2^10 (10-bit number only availble in hardware)
	{
		*(led3_dc) = val;  //*(address) = val;
	}
}

//Set PWM frequency for LD0
void setled0_freq(data val)
{
	*(led0_freq) = val;
}

//Set PWM frequency for LD1
void setled1_freq(data val)
{
	*(led1_freq) = val;
}

//Set PWM frequency for LD2
void setled2_freq(data val)
{
	*(led2_freq) = val;
}

//Set PWM frequency for LD3
void setled3_freq(data val)
{
	*(led3_freq) = val;
}

//Pass binary numbers (easiest) to tell which LEDs to enable
void enable_LEDs(int to_enable)
{
	*(enable) = to_enable;
}

//delay for some time
void delay(int i)
{
	int k = 0;
    while ( k < i )
    	k++;
}

int main(void)
{
	enable_LEDs(0b1111);

	/*
	//demonstrates low resolution PWM frequency
	setled0_freq(4);
	int i = 0;
	while (1)
	{
		setled0_dc(i);
		i++;
		if (i > 4)
		{
			i = 0;
		}
		delay(10000000);
	}
	*/

	//demonstrates smooth, high resolution PWM frequency
	setled0_freq(400);
	int i = 0;
	while (1)
	{
		setled0_dc(i);
		i++;
		if (i > 400)
		{
			i = 0;
		}
		delay(1000000);
	}

	return 0;
}
