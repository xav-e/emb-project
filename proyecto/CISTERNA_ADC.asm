LIST P=16f877a;	    INDICANDO PROCESADOR
;INCLUYENDO LAS LIBRERIA QUE VAMOS A UTILIZAR
    #include "p16f877a.inc"    

; CONFIG. DEL CLOCK A 20MHZ, WATCHDOG DESHABILITADO Y POWER-UP TIMER ON
    __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

;* DEFINICION DE VARIABLES Y SU ALMACENAMIENTO
;*
    CBLOCK 0x20
	NOMBRE_1	; VARIABLE 1
	NOMBRE_2	; VARIABLE 2
	NOMBRE_3	; VARIABLE 3
    ENDC

    ORG	0X00
    BCF	STATUS,RP1;
    BCF	STATUS,RP0;	CAMBIO DE BANCO
;BANCO 0
    GOTO	INICIO
INICIO:						
/*******************************************************************************
**********************  CISTERNA  ***********************************************/
	BCF	STATUS,RP1;
	BSF	STATUS,RP0;	CAMBIO DE BANCO
;BANCO 1
	MOVLW	0X2F; 00101111B CONFIG PUERTO A CON 5 ENTRADAS Y UNA SALIDA(RA4)
	MOVWF	TRISA;		RA0:RA3,RA5 ->	ENTRADAS
;CONFIGURACION DE LOS PINES DEL CONVERTIDOR A/D, AFECTA 8 PINES
;RA0-RA5 Y RE0-RE2
	BSF	ADCON1,PCFG3;	PCFG3:PCFG0 (ADCON1<3:0>)	
	BSF	ADCON1,PCFG2
	BSF	ADCON1,PCFG1
	BCF	ADCON1,PCFG0; 	0010 -> 5 INPUTS A Y 3 I/O DIGITALES
/*
    RA0 = AN0 -> INPUT NO INV COMPARADOR A 1
    RA1 = AN1 -> INPUT NO INV COMPARADOR A 2
    RA2 = AN2 -> SOBREESCRITO AL USAR EL COMPARADOR? I/O DIGITAL, NON-USED
    RA3 = AN3 -> INPUT INV COMPARADOR A 1 Y 2, REFERENCIA COMUN
    RA5 = AN4 -> INPUT CONVERTIDOR A/D -> CANAL
*/
	BSF	ADCON1,ADCS2;	SELECCION DEL BIT DE CONVERSION 2 DEL CLOCK: FOSC/64
	BCF	ADCON1,ADFM; 	JUSTIFICADO A LA IZQ, ENMASCARA BITS <1:0>
;LOS PASOS DEBERIAN SER MULTIPLOS DE CUATRO PARA QUE LOS AGARRE???
	BCF	STATUS,RP0
	BCF	STATUS,RP1
;BANCO 0
	BSF	ADCON0,ADCS1;	CONVERSION DEL RELOJ
	BCF	ADCON0,ADCS0; 	FOSC/64 -> 110
	BSF	ADCON0,CHS2;	SELECCION DEL CANAL ANALOGICO
	BCF	ADCON0,CHS1
	BCF	ADCON0,CHS0; 	CANAL AN4
	BSF	ADCON0,AD0N; 	ADC ON
	

START:
	BCF	STATUS,Z
	BCF	STATUS,C;
	BSF	ADCON0,2; 	COMIENZA LA CONVERSION GO/!DONE -> 1
	GOTO	ADC
	

ADC:		
; NIVEL 1: 1 VOLTIOS < NIVEL < 2.5 VOLTIOS
; NIVEL 2: 2.5 VOLTIOS < NIVEL < 4 VOLTIOS
; NIVEL 3: 4 VOLTIOS < NIVEL < 5 VOLTIOS
	BTFSC	ADCON0,2
	GOTO	ADC;		MIENTRAS CONVERTIMOS
	BSF	STATUS,RP0
	MOVF	ADRESH,W;	NIVEL DEL TANQUE
	BCF	STATUS,RP0
	SUBLW   D'128';		TESTEAR CON LA MITAD
	BTFSC 	STATUS,Z
	GOTO    MITAD;		2.5 VOLTIOS DE NIVEL
	BTFSS	STATUS,C
	GOTO	MLLENO;		NIVEL > 2.5 VOLTIOS
	GOTO    MVACIO;		NIVEL < 2.5 VOLTIOS


MITAD:							
;ACA PODRIA SER ESE NIVEL QUE HABLAMOS UNA VEZ APAGADA LA BOMBA POR
;FALTA DE AGUA SEA EL MINIMO NIVEL DE LLENADO PARA VOLVERLA A ENCENDER
	GOTO	START;  		


MLLENO:		
	BCF	STATUS,Z
	BCF	STATUS,C;	LIMPIA BANDERAS
	BSF	STATUS,5
	MOVF	ADRESH,W;	NIVEL DEL TANQUE
	BCF	STATUS,5
	SUBLW	D'204';		TESTEAR CON 4 VOLTIOS
	BTFSC 	STATUS,Z
	GOTO    CUATRO;		4 VOLTIOS DE NIVEL
	BTFSS	STATUS,C
	GOTO	MAYOR4;		NIVEL > 4 VOLTIOS
	GOTO    NIVEL2;		NIVEL < 4 VOLTIOS

		
CUATRO:	
	GOTO 	START;

		
MAYOR4:
	BCF	STATUS,Z
	BCF	STATUS,C;	ESTAS BANDERAS HAY QUE LIMPIARLAS
	BSF	STATUS,5
	MOVF	ADRESH,W;	NIVEL DEL TANQUE
	BCF	STATUS,5
	SUBLW	D'250';		TESTEAR CON 5 VOLTIOS
	BTFSC 	STATUS,Z
	GOTO    LLENO;		5 VOLTIOS DE NIVEL
	BTFSS	STATUS,C
	GOTO	AGUAAA;		NIVEL > 5 VOLTIOS
	GOTO    NIVEL3;		NIVEL < 5 VOLTIOS
	

LLENO:
    ;DE MADRUGADA Y SI ACASO PQ AJA
	GOTO 	START				


NIVEL3:
    ; NIVEL 3
	GOTO	START						


AGUAAA:
    ;DESPIERTA ESTO ES VENEZUELA
	GOTO 	START


NIVEL2:
    ;NIVEL 2
	GOTO	START	


MVACIO:	
	BCF	STATUS,Z
	BCF	STATUS,C;   ESTAS BANDERAS TAMBIEN HAY QUE LIMPIARLAS
	BSF	STATUS,5
	MOVF	ADRESH,W;   NIVEL DEL TANQUE
	BCF	STATUS,5
	SUBLW	D'52';	    TESTEAR CON 1 VOLTIO
	BTFSC 	STATUS,Z
	GOTO    BOMBAOFF;   1 VOLTIO DE NIVEL
	BTFSS	STATUS,C
	GOTO	NIVEL1;	    NIVEL > 1 VOLTIO
	GOTO	SEQUEMO;    NIVEL <	1 VOLTIO


BOMBAOFF:
	GOTO	START

NIVEL1:
    ;NIVEL 1
	GOTO	START


SEQUEMO:
	GOTO	FERRETERIA	


FERRETERIA:
;BUENO BRO OBVIO A FALTA DE AGREGARLE UN SENTIDO AL DESCUBRIMIENTO DE CADA NIVEL LO VEO BIEN
;SE ME OCURRE MANEJAR CALLS EN CADA NIVEL QUE DEN PASO A NOTIFICAR EL NIVEL
;DICHA NOTIFICACION GUIA LAS ACCIONES A TOMAR Y CHILL CON EL RETURN DEL CALL
;YA VOLVERIAMOS A NUESTRO BELLO GOTO START PARA SEGUIR VIENDO LOS NIVELES
;CREO QUE ASI SEGUIRIAMOS EL FLUJO DE QUE EL NIVEL DETERMINA LAS ACCIONES A TOMAR OBVIO CON
;CON TODAS SUS RESPECTIVAS PREGUNTAS Y OTROS CONDICIONANTES PERO NI IDEA JAJAJAJ
;
;		
;	
;UPDATE 01/08 - 1:27: BRO, SI ACTIVAMOS MODO MANUAL HAY QUE PONER EL A/D CON EL RELOJ INTERNO PORQUE EN SLEEP SE APAGA EL CRISTAL, ES DECIR EL ADCON0 DEBE ESTAR EN B '00000011' ES DECIR 0X03
;VER LA P�g 129 del manual y la tabla por si no me explique bien, creo que en esencia solo le cambia la velocidad al clock, que ahora es interno
;no lo modifique directamente, porque no quiero cambiarte nada sin saber
;SLEEP PAG 158
END