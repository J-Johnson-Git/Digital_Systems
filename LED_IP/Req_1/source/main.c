/*
 * 	This project is requirement 1 of project 1 in EE324. It verifies the demo project, which just blinks the first four LEDs on the Blackboard through
 * 	our custom hardware
 *

#include "xil_types.h"

// Macro to access the base address of your LED controller
#define my_LED *((uint32_t *)0x4BB00000)

int main()
{
    int i = 0;

    // Turn off all LEDs
    my_LED = 0x00;

    // Infinite loop
    while (1) {

        // invert the LED value
	my_LED= ~my_LED;

        // Delay
        for (i = 0; i < 10000000; i++);
    }
    return 1;
}
*/
