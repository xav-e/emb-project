LIST P=16f877a
#include "p16f877a.inc"
contador equ 0x30
otro	equ	0x31

	ORG	0X00
	GOTO	INICIO


;TINACO

BANK0:
    BCF	STATUS,RP1;
    BCF	STATUS,RP0;
RETURN
    
BANK1:
    BCF	STATUS,RP1;
    BSF	STATUS,RP0;
RETURN

INICIO:
;CAMBIO A BANCO 1
	BSF	STATUS,RP0
	BSF	TRISA,RA0;	RA0 ENTRADA
	BSF	ADCON1,PCFG3		
	BSF	ADCON1,PCFG2
	BSF	ADCON1,PCFG1
	BCF	ADCON1,PCFG0;	1110 -> RA0 AN0 = ANALOGICO
	BSF	ADCON1,ADCS2; 	FOSC/64 
	BCF	ADCON1,ADFM; 	JUSTIFICACION IZQ PORQUE ME INTERESAN LOS 8 BITS MAS SIGNIFICATIVOS
;CAMBIO DE BANCO
	BCF	STATUS,RP0
	BSF	ADCON0,ADCS1
	BCF	ADCON0,ADCS0; 	FOSC/64 -> 110
	BCF	ADCON0,CHS2
	BCF	ADCON0,CHS1
	BCF	ADCON0,CHS0; 	CANAL AN0 -> 000
	BSF	ADCON0,ADON; 	ADC ON


START:
	BCF	STATUS,Z
	BCF	STATUS,C;
	BSF	ADCON0,2; 	GO/DONE -> 1

	GOTO	ADC


ADC:		
; NIVEL 1: 0 VOLTIOS < NIVEL < 2.5 VOLTIOS
; NIVEL 2: 2.5 VOLTIOS < NIVEL < 4 VOLTIOS
; NIVEL 3: 4 VOLTIOS < NIVEL < 5 VOLTIOS
    
    
	BTFSC	ADCON0,2	
	GOTO	ADC;		MIENTRAS CONVERTIMOS
	BSF	STATUS,RP0
	MOVF	ADRESH,0;	NIVEL DEL TANQUE
	BCF	STATUS,RP0
	SUBLW   D'128';		128 - W TESTEAR CON LA MITAD
	BTFSC 	STATUS,Z
	GOTO    MITAD;		2.5 VOLTIOS DE NIVEL
	BTFSS	STATUS,C
	GOTO	MLLENO;		NIVEL > 2.5 VOLTIOS
	GOTO    MVACIO;		NIVEL < 2.5 VOLTIOS
	
	
MITAD:	
	BTFSC	PORTB, RB3;	CHEQUEAR BOMBA, LO PUSE AS� PARA QUITAR EL ERROR, PERO SEGUIR CAPTANDO LA IDEA
	GOTO	START;  	NO CREO QUE CONSTANTEMENTE HAYA QUE MANDAR A ENCENDER LA BOMBA PERO PORSIA ESTE COMENTARIO
	GOTO	CISTERNAVACIA
	
	
MLLENO:	
	BCF	STATUS,Z
	BCF	STATUS,C;	NO SE SI ESTAS BANDERAS TAMBIEN HAY QUE LIMPIARLAS PERO PORSIA
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
	GOTO 	START;		YA DEJE DE PONER COSAS DE LA BOMBA ME DEDICARE A QUE DIGA BIEN EL NIVEL


MAYOR4:
	BCF	STATUS,Z
	BCF	STATUS,C;	HAY QUE LIMPIARLAS PERO PORSIA
	BSF	STATUS,5
	MOVF	ADRESH,W;	NIVEL DEL TANQUE
	BCF	STATUS,5
	SUBLW	D'250';		TESTEAR CON 5 VOLTIOS
	BTFSC 	STATUS,Z
	GOTO    LLENO;		5 VOLTIOS DE NIVEL
	BTFSS	STATUS,C
	GOTO	AGUAAA;		NIVEL > 5 VOLTIOS
	GOTO    NIVEL3;		NIVEL < 5 VOLTIOS


LLENO:;				APAGAMOS BOMBA Y ESO
	GOTO 	START
	

NIVEL3:;			NIVEL 3
	GOTO	START

	
AGUAAA:;			DESPIERTA ESTO ES VENEZUELA
	GOTO 	START

	
NIVEL2:;			NIVEL 2
	GOTO	START


MVACIO:	
	BCF	STATUS,Z
	BCF	STATUS,C;	HAY QUE LIMPIARLAS
	BSF	STATUS,5
	MOVF	ADRESH,0;	NIVEL DEL TANQUE
	BCF	STATUS,5
	SUBLW	D'0';		TESTEAR CON 0 VOLTIOS
	BTFSC 	STATUS,Z
	GOTO    VACIO;		0 VOLTIOS DE NIVEL
	GOTO	NIVEL1;		NIVEL > 0 VOLTIOS

VACIO:
	GOTO	MIRAFLORES
	
	
NIVEL1:;			NIVEL 1
	GOTO	START
	
	
;BUENO BRO OBVIO A FALTA DE AGREGARLE UN SENTIDO AL DESCUBRIMIENTO DE CADA NIVEL LO VEO BIEN
;SE ME OCURRE MANEJAR CALLS EN CADA NIVEL QUE DEN PASO A NOTIFICAR EL NIVEL
;DICHA NOTIFICACION GUIA LAS ACCIONES A TOMAR Y CHILL CON EL RETURN DEL CALL
;YA VOLVERIAMOS A NUESTRO BELLO GOTO START PARA SEGUIR VIENDO LOS NIVELES
;CREO QUE ASI SEGUIRIAMOS EL FLUJO DE QUE EL NIVEL DETERMINA LAS ACCIONES A TOMAR OBVIO CON
;CON TODAS SUS RESPECTIVAS PREGUNTAS Y OTROS CONDICIONANTES PERO NI IDEA JAJAJAJ


BOMBA:
NOP
GOTO START


MIRAFLORES:
NOP
GOTO START


CISTERNAVACIA:
NOP
GOTO START


END