/*
 * EE324
 * Project 4
 * Requirement 2
 * Josh Johnson
 * 7/9/20
 *
 * Controller for PWM IP made in Vivado
 * Works on LD3 - LD0 (first 4 green LEDs on Blackboard)
 * Enable function to allow certain LEDs to be on/off
 * Duty Cycle function to pass a duty cycle to a particular LED
 *
 * Uses 'PWM_Controller' hardware build
 */

#pragma once
#ifndef header_h
#define header_h
#include "stdio.h"
#include "stdlib.h"
#include "xil_types.h"

#define LED0_en 0b0001
#define LED1_en 0b0010
#define LED2_en 0b0100
#define LED3_en 0b1000


typedef uint32_t* addr;
typedef uint32_t data;

const addr enable = (addr) 0x4BB03000;
const addr led0_dc = (addr) 0x4BB03004;
const addr led1_dc = (addr) 0x4BB03008;
const addr led2_dc = (addr) 0x4BB0300C;
const addr led3_dc = (addr) 0x4BB03010;

void setled0_dc(data val);
void setled1_dc(data val);
void setled2_dc(data val);
void setled3_dc(data val);
void enable_LEDs(int to_enable);
void delay(int i);

#endif
