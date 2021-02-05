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
	setled0_dc(0b0000000001);
	setled1_dc(0b0000000100);
	setled2_dc(0b0000010000);
	setled3_dc(0b0001000000);
	return 0;
}
