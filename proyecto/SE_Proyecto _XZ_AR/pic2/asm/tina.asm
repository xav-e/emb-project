LIST P=16f877a;	    INDICANDO PROCESADOR
;INCLUYENDO LAS LIBRERIA QUE VAMOS A UTILIZAR
    #include "p16f877a.inc"    

; CONFIG. DEL CLOCK A 20MHZ, WATCHDOG DESHABILITADO Y POWER-UP TIMER ON
    __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

;* DEFINICION DE VARIABLES Y SU ALMACENAMIENTO
;*
    CBLOCK 0xA0
	NIVEL	; VARIABLE 1
    ENDC
	
    ORG	0X00
    GOTO COMIENZO
    ORG 0X04
    GOTO INTERRUPT
INTERRUPT:
    RETFIE
; ******************************************************************************
;***********************  TINACO ***********************************************
COMIENZO:						
		BSF STATUS,5;		CAMBIO A BANCO 1

;SERIAL
		BCF TRISC,6;	    TX PIN COMO SALIDA
		BSF TRISC,7;	    RX PIN COMO INPUT
		MOVLW h'81';	    X=129
		MOVWF SPBRG;	    CONFIGURANDO EL BAUD RATE A 9600 BAUD/S CON EL CLOCK DE 20MHZ
		MOVLW h'26';	    TXEN=1, BRGH=1, TRMT=1, ESTE ES READ ONLY, PERO AJA, SIN PARIDAD
		MOVWF TXSTA;	    CONFIGURANDO TXSTA COMO ASINCRONO

		MOVLW h'C0'
		MOVWF INTCON; HABILITANDO GIE Y PEIE, esto tampoco hace nada
		BSF PIE1,RCIE
		BCF STATUS, RP1
		BCF STATUS, RP0;    CAMBIO A BANCO 0

		MOVLW h'90'
		MOVWF RCSTA;	    CONFIGURANDO EL RCSTA PARA ASINCRONO
		BCF PIR1, RCIF;	    LIMPIANDO LA BANDERA DE RECEPCION, no hace nada
		BSF STATUS,RP0					
;TINACO
		BSF		TRISA,0; 		RA0 ENTRADA
		BSF		ADCON1,3
		BSF		ADCON1,2
		BSF		ADCON1,1
		BCF		ADCON1,0; 		1110 -> RA0 AN0 = ANALOGO
		BSF		ADCON1,6; 		
		BCF		ADCON1,7; 		JUSTIFICACION DERLOS PASOS DEBERIAN SER MULTIPLOS DE CUATRO PARA QUE LOS AGARRE???
		BCF		STATUS,RP0
		BCF		STATUS,RP1
		BSF		ADCON0,ADCS1;	CONVERSION DEL RELOJ
		BCF		ADCON0,ADCS0; 	FOSC/64
		BCF		ADCON0,CHS2;	SELECCION DEL CANAL ANALOGICO
		BCF		ADCON0,CHS1
		BCF		ADCON0,CHS0; 	CANAL AN0
		BSF		ADCON0,0;		ADC ON
;SERIAL
START:
		CALL Retardo_400ms
		MOVF	ADRESH,NIVEL
		BSF		ADCON0,2		; 	GO/!DONE -> 1
		CALL Retardo_400ms

ADC:		
								; NIVEL 1: 0 VOLTIOS < NIVEL < 2.5 VOLTIOS
								; NIVEL 2: 2.5 VOLTIOS < NIVEL < 4 VOLTIOS
								; NIVEL 3: 4 VOLTIOS < NIVEL < 5 VOLTIOS
		BTFSC	ADCON0,2
		GOTO	ADC;			MIENTRAS CONVERTIMOS
		BCF		STATUS,Z
		BCF		STATUS,C
		MOVF	ADRESH,W;		NIVEL DEL TANQUE
		SUBLW   D'128';			TESTEAR CON LA MITAD
		BTFSC 	STATUS,Z
		GOTO    MITAD;			2.5 VOLTIOS DE NIVEL
		BTFSS	STATUS,C
		GOTO	MLLENO;			NIVEL > 2.5 VOLTIOS
		GOTO    MVACIO;			NIVEL < 2.5 VOLTIOS


MITAD:							
		CALL 	BOMBAON
		;BTFSS  	w,w			 	;
		GOTO	MITAD
		GOTO	START;  		


MLLENO:	
		BCF		STATUS,Z
		BCF		STATUS,C;		
		MOVF	ADRESH,W;		NIVEL DEL TANQUE
		SUBLW	D'205';			TESTEAR CON 4 VOLTIOS
		BTFSC 	STATUS,Z
		GOTO    CUATRO;			4 VOLTIOS DE NIVEL
		BTFSS	STATUS,C	
		GOTO	MAYOR4;			NIVEL > 4 VOLTIOS
		GOTO    NIVEL2;			NIVEL < 4 VOLTIOS

		
CUATRO:	
		CALL	BOMBAON			;	    
		;BTFSS  					;
		GOTO	CUATRO
		GOTO	START; 

		
MAYOR4:
		BCF		STATUS,Z
		BCF		STATUS,C;	
		MOVF	ADRESH,W;		NIVEL DEL TANQUE
		SUBLW	D'255';			TESTEAR CON 5 VOLTIOS
		BTFSC 	STATUS,Z
		GOTO    LLENO;			5 VOLTIOS DE NIVEL
		BTFSS	STATUS,C
		GOTO	AGUAAA;			NIVEL > 5 VOLTIOS
		GOTO    NIVEL3;			NIVEL < 5 VOLTIOS
	

LLENO:
    	CALL 	BOMBAOFF		
		;BTFSC                   ;COMPROBAMOS QUE ESTA APAGADA
        GOTO    LLENO
		GOTO 	START				


NIVEL3:
   		MOVF	ADRESH,W
		SUBWF	NIVEL,W			;NIVEL PREVIO - NIVEL ACTUAL
		BTFSC 	STATUS,Z
		GOTO    ABAJO			;IGUAL
		BTFSS	STATUS,C
		GOTO	ARRIBA	;		ESTAMOS LLENANDO
		GOTO    ABAJO;		YA ESTABAMOS EN 5 VOLTIOS Y VENIMOS BAJANDO	
		GOTO	START						
ABAJO	
		CALL 	BOMBAOFF
		;BTFSC
		GOTO	ABAJO
		GOTO 	START
ARRIBA	
		CALL	BOMBAON
		;BTFSC
		GOTO 	ARRIBA
		GOTO	START

AGUAAA:
   		CALL	BOMBAOFF		;DESPIERTA ESTO ES VENEZUELA
		;BTFSC					;ESTE CASO SOLO LO ESTARIAMOS MANEJANDO PARA EL SUPUESTO ERROR DE
		GOTO	AGUAAA			;TENER AGUA DE MAS Y SIMPLEMENTE CERRAMOS LA VALVULA COMO EL LLENO
		GOTO 	START


NIVEL2:
   		CALL	BOMBAON			;NIVEL 2
		;BTFSS   				;TESTEAMOS ESTADO DE LA VALVULA
		GOTO	NIVEL2					
		GOTO	START	


MVACIO:	
		BCF		STATUS,Z
		BCF		STATUS,C;	  	
		MOVF	ADRESH,W;      	NIVEL DEL TANQUE
		SUBLW	D'0';		   	TESTEAR CON 0 VOLTIOS
		BTFSC 	STATUS,Z
		GOTO    CRITICO;	   	0 VOLTIO DE NIVEL
		BTFSS	STATUS,C
		GOTO	NIVEL1;		   	NIVEL > 0 VOLTIOS
		GOTO	CRITICO;       	NIVEL < 0 VOLTIOS


CRITICO:
		CALL	BOMBAOFF		;TODO MAL
		GOTO	START

NIVEL1:
    	CALL	BOMBAON			;NIVEL 1
		;BTFSS					;TESTEAMOS 
		GOTO	NIVEL1
		GOTO	START

BOMBAON	
		MOVF	ADRESH,W
		SUBWF	NIVEL,W			;NIVEL PREVIO - NIVEL ACTUAL
		BTFSC 	STATUS,Z
		GOTO    PRENDE			;IGUAL
		BTFSS	STATUS,C
		RETURN					;		ESTAMOS LLENANDO
		GOTO    PRENDE;			YA ESTABAMOS EN 5 VOLTIOS Y VENIMOS BAJANDO						
PRENDE	
		MOVLW	0X01
		MOVWF	TXREG
		CALL	TRANSMIT
		GOTO	START
BOMBAOFF
		MOVF	ADRESH,W
		SUBWF	NIVEL,W			;NIVEL PREVIO - NIVEL ACTUAL
		BTFSC 	STATUS,Z
		RETURN					;IGUAL
		BTFSS	STATUS,C
		GOTO	APAGA			;		ESTAMOS LLENANDO AHORA APAGAMOS
		RETURN			
APAGA
		MOVLW	0X00
		MOVWF	TXREG
		CALL	TRANSMIT;RUTINA DE APAGAR BOMBA
		GOTO 	START
TRANSMIT:
		BTFSS PIR1, TXIF;    VERIFICO QUE EL BUFFER EST� VACIO PARA COMENZAR LA TRANSMISI�N
		GOTO TRANSMIT; HAY QUE LIMPIA		
RETURN
INCLUDE "aqtime.inc"
 
END