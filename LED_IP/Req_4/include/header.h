/*
 * EE324
 * Project 1
 * Requirement 4
 * Josh Johnson
 * 6/1/20
 *
 * This program tests the 'enable function added to the LED IP Block
 * Uses 'p1r4' hardware build
 */

#pragma once
#ifndef header_h
#define header_h

#include "xil_types.h"
#include "stdio.h"
#include "stdlib.h"

#define en_LED *((uint32_t *)0x40000000)
#define my_LED *((uint32_t *)0x40000004)

void enable(uint32_t en, uint32_t val);

#endif

