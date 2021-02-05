/*
 * EE324
 * Project 1
 * Requirement 2
 * Josh Johnson
 * 5/25/20
 *
 * This program will display different blinking patterns on the LEDs
 * Uses 'p1r1' hardware build
 */

#pragma once
#ifndef header_h
#define header_h

#include "xil_types.h"
#define my_LED *((uint32_t *)0x4BB00000)

int right_to_left(void);
int left_to_right(void);
int back_and_forth(void);
int bin_counting(void);


#endif
