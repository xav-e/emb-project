LIST P=16f877a
#include "p16f877a.inc"

	ORG	0
	GOTO	INICIO
INICIO							;TINACO
		BSF		STATUS,RP0
		BSF		TRISA,0; 		RA0 ENTRADA
		CLRF	TRISD;			SALIDA
		CLRF	TRISC; 			SALIDA
		BSF		ADCON1,3
		BSF		ADCON1,2
		BSF		ADCON1,1
		BCF		ADCON1,0; 		1110 -> RA0 AN0 = ANALOGO
		BSF		ADCON1,6; 		FOSC/64
		BSF		ADCON1,7; 		JUSTIFICACION DER
		BCF		STATUS,RP0
		BSF		ADCON0,7
		BCF		ADCON0,6; 		FOSC/64
		BCF		ADCON0,5
		BCF		ADCON0,4
		BCF		ADCON0,3; 		CANAL AN0
		BSF		ADCON0,0; 		ADC ON
START
		BSF		ADCON0,2; 		GO/DONE -> 1
ADC		
								; NIVEL 1: 1 VOLTIOS < NIVEL < 2.5 VOLTIOS
								; NIVEL 2: 2.5 VOLTIOS < NIVEL < 4 VOLTIOS
								; NIVEL 3: 4 VOLTIOS < NIVEL < 5 VOLTIOS
		BTFSC	ADCON0,2
		GOTO	ADC;			MIENTRAS CONVERTIMOS
		BSF		STATUS,RP0
		MOVF	ADRESL,W;		NIVEL DEL TANQUE
		BCF		STATUS,RP0
		SUBWF   D'128',W;		TESTEAR CON LA MITAD
		BTFSC 	STATUS,Z
		GOTO    MITAD;			2.5 VOLTIOS DE NIVEL
		BTFSS	STATUS,C
		GOTO	MLLENO;			NIVEL > 2.5 VOLTIOS
		GOTO    MVACIO;			NIVEL < 2.5 VOLTIOS
MITAD							;ACA PODRIA SER ESE NIVEL QUE HABLAMOS UNA VEZ APAGADA LA BOMBA POR
								;FALTA DE AGUA SEA EL MINIMO NIVEL DE LLENADO PARA VOLVERLA A ENCENDER
		GOTO	START;  		
MLLENO	
		BCF		STATUS,Z
		BCF		STATUS,C;		NO SE SI ESTAS BANDERAS TAMBIEN HAY QUE LIMPIARLAS PERO PORSIA
		BSF		STATUS,5
		MOVF	ADRESL,W;		NIVEL DEL TANQUE
		BCF		STATUS,5
		SUBWF	D'205',W;		TESTEAR CON 4 VOLTIOS
		BTFSC 	STATUS,Z
		GOTO    CUATRO;			4 VOLTIOS DE NIVEL
		BTFSS	STATUS,C
		GOTO	MAYOR4;			NIVEL > 4 VOLTIOS
		GOTO    NIVEL2;			NIVEL < 4 VOLTIOS
CUATRO	
		GOTO 	START;		
MAYOR4
		BCF		STATUS,Z
		BCF		STATUS,C;		NO SE SI ESTAS BANDERAS TAMBIEN HAY QUE LIMPIARLAS PERO PORSIA
		BSF		STATUS,5
		MOVF	ADRESL,W;		NIVEL DEL TANQUE
		BCF		STATUS,5
		SUBWF	D'255',W;		TESTEAR CON 5 VOLTIOS
		BTFSC 	STATUS,Z
		GOTO    LLENO;			5 VOLTIOS DE NIVEL
		BTFSS	STATUS,C
		GOTO	AGUAAA;			NIVEL > 5 VOLTIOS
		GOTO    NIVEL3;			NIVEL < 5 VOLTIOS
LLENO;							DE MADRUGADA Y SI ACASO PQ AJA
		GOTO 	START				
NIVEL3;							NIVEL 3
		GOTO	START						
AGUAAA;							DESPIERTA ESTO ES VENEZUELA
		GOTO 	START
NIVEL2;							NIVEL 2
		GOTO	START	
MVACIO	
		BCF		STATUS,Z
		BCF		STATUS,C;		NO SE SI ESTAS BANDERAS TAMBIEN HAY QUE LIMPIARLAS PERO PORSIA
		BSF		STATUS,5
		MOVF	ADRESL,W;		NIVEL DEL TANQUE
		BCF		STATUS,5
		SUBWF	D'51',W;		TESTEAR CON 1 VOLTIO
		BTFSC 	STATUS,Z
		GOTO    BOMBAOFF;		1 VOLTIO DE NIVEL
		BTFSS	STATUS,C
		GOTO	NIVEL1;			NIVEL > 1 VOLTIO
		GOTO	SEQUEMO;		NIVEL <	1 VOLTIO
BOMBAOFF
		GOTO	START
NIVEL1;							NIVEL 1
		GOTO	START
SEQUEMO
		GOTO	FERRETERIA	
FERRETERIA
								;BUENO BRO OBVIO A FALTA DE AGREGARLE UN SENTIDO AL DESCUBRIMIENTO DE CADA NIVEL LO VEO BIEN
								;SE ME OCURRE MANEJAR CALLS EN CADA NIVEL QUE DEN PASO A NOTIFICAR EL NIVEL
								;DICHA NOTIFICACION GUIA LAS ACCIONES A TOMAR Y CHILL CON EL RETURN DEL CALL
								;YA VOLVERIAMOS A NUESTRO BELLO GOTO START PARA SEGUIR VIENDO LOS NIVELES
								;CREO QUE ASI SEGUIRIAMOS EL FLUJO DE QUE EL NIVEL DETERMINA LAS ACCIONES A TOMAR OBVIO CON
								;CON TODAS SUS RESPECTIVAS PREGUNTAS Y OTROS CONDICIONANTES PERO NI IDEA JAJAJAJ
	END