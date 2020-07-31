list p=16f84a
    ; PIC16F84A Configuration Bit Settings
; Assembly source line config statements

#include "p16f84a.inc"

; CONFIG
; __config 0xFFF9
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF; TODO INSERT CONFIG CODE HERE USING CONFIG BITS GENERATOR
    
RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program
 
; TODO ADD INTERRUPTS HERE IF USED
 
CBLOCK 0x0C
    COUNT1
    COUNT2
ENDC
    
    
MAIN_PROG CODE                      ; let linker place main program
 
 START
    BSF STATUS, RP0
    MOVLW 0xFE
    MOVWF TRISB
    BCF STATUS, RP0
    
 MAIN
    BSF PORTB,0
    CALL DELAY
    BCF PORTB,0
    CALL DELAY
    GOTO MAIN
    
 DELAY
    LOOP1 DECFSZ COUNT1, 1
    GOTO LOOP1
    DECFSZ COUNT2,1
    GOTO LOOP1
    RETURN
 
    END