/*
 * File:   SLEEPER.c
 * Author: TNS
 *
 * Created on 26 May, 2014, 10:53 AM
 */


#include<pic.h>
#define _XTAL_FREQ 8000000
__CONFIG(FOSC_HS & WDTE_ON & PWRTE_OFF & BOREN_OFF & LVP_OFF & CPD_OFF & WRT_OFF & CP_OFF);
void main()
{
	TRISD =0x00;//PORT D OUTPUT
        PORTD=0x00;
        OPTION_REG=0x0F;// WATCHDOG TIMER TIME OUT PERIOD 2.3 SECONDS
        while(1)
        {
            PORTD=!(PORTD);// COMPLIMENT PORTD
            SLEEP();
        }

}