/*
 * EE324
 * Project 1
 * Requirement 3
 * Josh Johnson
 * 5/25/20
 *
 * This is a programming interface for the LED hardware block, includes read/write and others
 * Uses 'p1r1' hardware build
 */

#pragma once
#ifndef header_h
#define header_h

#include "xil_types.h"
#include <stdio.h>
#include "stdlib.h"
#include "xil_printf.h"
#include "platform.h"
#define my_LED *((uint32_t *)0x4BB00000)

uint32_t read_myLED(void);
void write_LED(uint32_t to_write);
void indiv_LED(uint32_t to_write);

#endif
