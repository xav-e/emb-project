	list p=16f84A
	include "p16f84A.inc"
	
		ORG 00h
		GOTO INICIO

		ORG 04h	
AQUI		BCF	PORTB,5
		BTFSS	PORTB,1;0
		GOTO	AQUI
		MOVLW	d'251'
		MOVWF	TMR0
		BCF	INTCON,2 ;limpia la bandera de interrupciòn
		RETFIE
				
		ORG  30h
INICIO		BSF	STATUS,5
		BCF	TRISB,5	; puerto RB5 como salida
		BCF	STATUS,5
		BSF 	INTCON,7 ; habilito las interrupciones globales 
		BSF 	INTCON,5 ; habilito la interrupción contador
		MOVLW	d'251'
		MOVWF	TMR0
ARRIBA		BSF	PORTB,5
		GOTO 	ARRIBA	
		END
