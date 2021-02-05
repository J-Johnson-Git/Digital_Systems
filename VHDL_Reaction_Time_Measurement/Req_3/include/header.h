#pragma once
#ifndef header_h
#define header_h
#include <stdio.h>
#include <stdlib.h>

typedef uint32_t* addr;
typedef uint32_t data;

const addr rand_num_addr = (addr) 0x40000000;  //send random number here
const addr gen_num_addr = (addr) 0x40000004;  //signal to generate new random number
const addr divisor = (addr) 0x40000008;  //divisor for average (how many times user has performed a reaction)
const addr bcd_0_addr = (addr) 0x4000000C;
const addr bcd_1_addr = (addr) 0x40000010;
const addr bcd_2_addr = (addr) 0x40000014;
const addr bcd_3_addr = (addr) 0x40000018;
const addr bcd_capture_addr = (addr) 0x4000001C;
const addr sum_div_addr = (addr) 0x40000020;
const addr bcd_return_0 = (addr) 0x40000024;
const addr bcd_return_1 = (addr) 0x40000028;
const addr bcd_return_2 = (addr) 0x4000002C;
const addr bcd_return_3 = (addr) 0x40000030;

void delay(int i);

#endif header_h
