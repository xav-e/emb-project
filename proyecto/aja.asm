LIST P=16f877a
#include "p16f877a.inc"
contador equ 0x30
otro	equ	0x31


Org      00h

 Inicio               
	movlw   30h

	movwf  30h

	movwf  31h

	movwf  FSR
	
	incf       FSR,1
	
	comf     INDF,1
	
	bsf       30h,5
	
	bsf       31h,1
	
	decf      FSR,1
	
	movlw  20h   addwf   INDF,1
	
	rrf         31h,1
	
	addwf   31h,1
	
	iorwf     INDF,1
	
	comf     31h,0

                        end