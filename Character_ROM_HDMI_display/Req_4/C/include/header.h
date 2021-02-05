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
const addr back_color_red = (addr) 0x4000000C;
const addr back_color_green = (addr) 0x40000010;
const addr back_color_blue = (addr) 0x40000014;
const addr char_color_red = (addr) 0x40000018;
const addr char_color_green = (addr) 0x4000001C;
const addr char_color_blue = (addr) 0x40000020;

void set_char(char user_char);
void set_x_pos(data x);
void set_y_pos(data y);
void set_back_red(data br);
void set_back_green(data bg);
void set_back_blue(data bb);
void set_char_red(data cr);
void set_char_green(data cg);
void set_char_blue(data cb);

#endif
