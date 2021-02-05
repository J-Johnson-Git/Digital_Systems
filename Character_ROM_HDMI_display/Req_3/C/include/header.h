#pragma once
#ifndef header_h
#define header_h
#include "stdio.h"
#include "stdlib.h"
#include "xil_types.h"

/*
 *  x = 144;
 *  x = 35;
 *  for upper left corner
 *
 *  Requirement 3 AXI controller for VGA system
 */

typedef uint32_t* addr;
typedef uint32_t data;

const addr char_sel = (addr) 0x40000000;
const addr x_pos = (addr) 0x40000004;
const addr y_pos = (addr) 0x40000008;

void set_char(char user_char);
void set_x_pos(data x);
void set_y_pos(data y);

#endif
