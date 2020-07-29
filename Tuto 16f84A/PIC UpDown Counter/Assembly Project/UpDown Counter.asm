list p=16F84
#include "p16f84.inc"     ; This includes PIC16F84 definitions for the MPASM assembler
;**************************************************************
;*
;* PIN Assignment
;*	----------------------------------	
;*	PORTA:
;*		0 IN
;*		1 IN
;*		2 IN
;*		3 IN
;*		4 IN
;*	PORTB:
;*		0 LED	   
;*		1 LED	    
;*		2 LED	    
;*		3 LED	     
;*		4 LED	    
;*		5 LED	    
;*		6 LED	    
;*		7 LED	    
;*
; Declare variables **************************************************************
;
DELAYCOUNT1		EQU		0x1A	; VARIABLES USED IN DELAY CALLS
DELAYCOUNT2		EQU		0x1B	; VARIABLES USED IN DELAY CALLS
Counter			EQU		0x1C


;INIT **************************************************************

; Set Port B for output and Port A for input	
	BSF		STATUS,RP0		; BANK 1
	MOVLW	0x00                       
	MOVWF	TRISB			; ENABLE PORT B AS OUTPUT
	MOVLW	0x1F                       
	MOVWF	TRISA			; ENABLE PORT A AS INPUT
	BCF		STATUS,RP0		; BANK 0
	
; Turn Off display (inverted logic) and set counter to 0
	MOVLW	0xFF                     
	MOVWF	PORTB
	MOVLW	0x00 	
	MOVWF	Counter


	
; Main loop **************************************************************
Loop
	CALL	DELAY			; delay loop execution
	BTFSC   PORTA, 0        ; read RA0
    GOTO    Display_OFF ; if RA0 High
    GOTO    Counter_Start   ; if RA0 Low
    
    
Display_OFF					; turn display off and reset counter
	MOVLW   0xFF               
	MOVWF	PORTB
	MOVLW	0x00 	
	MOVWF	Counter
	GOTO 	Loop
    
    
Counter_Start
	BTFSC   PORTA, 1        ; read RA1
	GOTO	CountDown		; if RA1 High
	GOTO 	CountUp			; if RA1 Low
	
CountUp
	INCF  	Counter,1       ; increment counter by 1	
	BTFSS	Counter,4		; check for overflow >F
	GOTO	Display			; if counter <=F
	GOTO	Reset_INC		; if counter >F
	
CountDown
	DECF 	Counter,1       ; decrement counter by 1
	BTFSS	Counter,5		; check for overflow <0
	GOTO	Display			; if counter >=0
	GOTO	Reset_DEC		; if counter <0

Reset_INC					; reset counter to 0 after INC overflow
	MOVLW	0x00 	
	MOVWF	Counter	
	GOTO 	Display
Reset_DEC					; reset counter to F after DEC overflow
	MOVLW	0x0F 	
	MOVWF	Counter
Display						; Display counter on 7-segment-display
	CALL	Segmente
	MOVWF	PORTB
	GOTO 	Loop

	
; Lookup table for 7-Segment Display (inverted logic)***************************************** 
Segmente 
	MOVF	Counter,0 
 	addwf 	PCL, f 
 ;            76543210
 	retlw 	B'11000000' ; 0 C0
 	retlw 	B'11111001' ; 1 F9
 	retlw 	B'10100100' ; 2 A4
 	retlw 	B'10110000' ; 3 B0
	retlw 	B'10011001' ; 4 99
 	retlw 	B'10010010' ; 5 92
 	retlw 	B'10000010' ; 6 82
 	retlw 	B'11111000' ; 7 F8
 	retlw 	B'10000000' ; 8 80
 	retlw 	B'10010000' ; 9 90
 	retlw 	B'10001000' ; A 88
 	retlw 	B'10000011' ; B 83
 	retlw 	B'11000110' ; C C6
 	retlw 	B'10100001' ; D A1
	retlw 	B'10000110' ; E 86
 	retlw 	B'10001110' ; F 8E
	
		

; Delay Call ***************************************** 
; A DELAY IS NEEDED, LONG ENOUGH TO WRITE INTO EEPROM
DELAY
	MOVLW	0xF7			; SET/RESET COUNTER
	MOVWF	DELAYCOUNT1
	MOVLW	0xAA			;SET COUNTER DELAYCOUNT2 TO 0
DELAYLOOP1
	MOVWF	DELAYCOUNT2
DELAYLOOP2
	INCFSZ	DELAYCOUNT2,1
	GOTO 	DELAYLOOP2
	INCFSZ	DELAYCOUNT1,1
	GOTO 	DELAYLOOP1
	RETURN


	end



