#include "header.h"

/*
 *	3 2 1 0 (7seg bcd names) (left to right)
 */

void delay(int i)
{
	int k = 0;
    while ( k < i )
    	k++;
}

int main (void)
{
    //flags from hardware, divisor and random number we gen here
	data rand_num = 0;
	data rst = 0;
	data divisor_var = 0;
	data bcd_capture_flag = 0;
	data sum_div_flag = 0;

	//bcd capture
	data bcd_0 = 0;
	data bcd_1 = 0;
	data bcd_2 = 0;
	data bcd_3 = 0;

	//bcd capture -> double
	double bcd_0_double = 0.0;
	double bcd_1_double = 0.0;
	double bcd_2_double = 0.0;
	double bcd_3_double = 0.0;

	int check_1 = 0;  //ensure bcd flag if statement only runs once
	int check_2 = 0;  //ensure sum div flag if statement only runs once

	//doubles for averaging
	double concantonate = 0.0;
	double con_accum = 0.0;
	double avg = 0.0;

	//cast average double into int and then seperate bcd ints
	int cast_int = 0;
	int avg_3 = 0;
	int avg_2 = 0;
	int avg_1 = 0;
	int avg_0 = 0;

	while (1)
	{
		//loading flags from hardware, loading divisor for average
		rst = *(gen_num_addr);
		bcd_capture_flag = *(bcd_capture_addr);
		sum_div_flag = *(sum_div_addr);
		divisor_var = *(divisor);

		if (rst)  //gen new random number, rst system
		{
			check_1 = 0;
			check_2 = 0;
			rand_num = rand() % 10 + 1;
			*(rand_num_addr) = rand_num;
		}

		if (bcd_capture_flag)  //capture what's on bcd right now
		{
			if (check_1 == 1)  //break out if we've gone through this if statement once before rst triggered
			{
				goto bcd_jmp;
			}

			//load data from each bcd digit into variable
			bcd_0 = *(bcd_0_addr);
			bcd_1 = *(bcd_1_addr);
			bcd_2 = *(bcd_2_addr);
			bcd_3 = *(bcd_3_addr);

			//cast bcd data to doubles
			bcd_0_double = (double) bcd_0;
			bcd_1_double = (double) bcd_1;
			bcd_2_double = (double) bcd_2;
			bcd_3_double = (double) bcd_3;

			//making correct decimals places for bcds
			bcd_2_double *= 0.1;
			bcd_1_double *= 0.01;
			bcd_0_double *= 0.001;

			//sum together all bcd digits into one double
			concantonate = bcd_0_double + bcd_1_double + bcd_2_double + bcd_3_double;

			//incr flag to ensure statement only runs once
		    check_1++;
		}
		bcd_jmp:  //from goto, skips if statement contents

		if (sum_div_flag)  //perform accum and div
		{
			if (check_2 == 1)  //break out if we've gone through this if statement once
			{
				goto sum_jmp;
			}

			//accumulate all bcd readings into one double
			con_accum += concantonate;

			//take average of current readings, multiply by 1000 and cast to int
			avg = con_accum / (double) divisor_var;
			avg *= 1000;
			cast_int = (int) avg;

			//Separate ints for each bcd digit, retrieve each decimal point
			avg_3 = cast_int / 1000;
			avg_2 = (cast_int / 100) % 10;
			avg_1 = (cast_int / 10) % 10;
			avg_0 = cast_int % 10;

			//send average bcd digits down to FPGA again
			*(bcd_return_0) = avg_0;
			*(bcd_return_1) = avg_1;
			*(bcd_return_2) = avg_2;
			*(bcd_return_3) = avg_3;

		    //incr flag to ensure statement only runs once
		    check_2++;
		}
		sum_jmp:  //from goto, skips if statement contents

		delay(10000);
	}
	return 0;
}
