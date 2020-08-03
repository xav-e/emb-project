LIST P=16f877a
#include "p16f877a.inc"
; CONFIG. DEL CLOCK A 20MHZ, WATCHDOG DESHABILITADO Y POWER-UP TIMER ON
; __config 0xFF72
 __CONFIG _FOSC_HS & _WDTE_OFF & _PWRTE_ON & _BOREN_ON & _LVP_OFF & _CPD_OFF & _WRT_OFF & _CP_OFF

 ;* DEFINICION DE VARIABLES Y SU ALMACENAMIENTO
;*
    CBLOCK 0x20
	NOMBRE_1	; VARIABLE 1
	NOMBRE_2	; VARIABLE 2
	NOMBRE_3	; VARIABLE 3
    ENDC

ORG	0X000
NOP
GOTO INICIO
INTERRUPTS:	ORG 0X04
	BTFSC, ;
	GOTO ;
	NOP
	BTFSC, ;
	GOTO ; O CALL COMO SEA
	NOP
	BTFSC, ;
	GOTO ;
	NOP
	BTFSC, ;
	GOTO ;
	NOP
	
	
	
INICIO:
;CONFIG DE LOS PUERTOS
    
;PUERTO A
    
    BCF STATUS, RP0     ;
    BCF STATUS, RP1     ; CAMBIO DE Bank0
    CLRF PORTA          ; INICIALIZO EL PORTA
			; LIMPIO EL REGISTRO
			; data latches
    BSF STATUS, RP0     ; Select Bank 1
    MOVLW 0x06          ; Configure all pins
    MOVWF ADCON1        ; as digital inputs
    MOVLW 0xCF          ; Value used to
			; initialize data
			; direction
    MOVWF TRISA         ; Set RA<3:0> as inputs
			; RA<5:4> as outputs
			; TRISA<7:6>are always
			; read as '0'.
;PUERTO B
    
    BCF STATUS, RP0     ;
    BCF STATUS, RP1     ; CAMBIO DE Bank0
    CLRF PORTB          ; INICIALIZO EL PORTB
			; LIMPIO EL REGISTRO
			; data latches
    BSF STATUS, RP0     ; Select Bank 1
    MOVLW 0x06          ; Configure all pins
    MOVWF ADCON1        ; as digital inputs
    MOVLW 0xCF          ; Value used to
			; initialize data
			; direction
    MOVWF TRISB         ; Set RB<3:0> as inputs
			; RB<5:4> as outputs
			; TRISB<7:6>are always
			; read as '0'.
;PUERTO C
    
    BCF STATUS, RP0     ;
    BCF STATUS, RP1     ; CAMBIO DE Bank0
    CLRF PORTC          ; INICIALIZO EL PORTC
			; LIMPIO EL REGISTRO
			; data latches
    BSF STATUS, RP0     ; Select Bank 1
    MOVLW 0x06          ; Configure all pins
    MOVWF ADCON1        ; as digital inputs
    MOVLW 0xCF          ; Value used to
			; initialize data
			; direction
    MOVWF TRISC         ; Set RC<3:0> as inputs
			; RC<5:4> as outputs
			; TRISC<7:6>are always
			; read as '0'.
;PUERTO D
    
    BCF STATUS, RP0     ;
    BCF STATUS, RP1     ; CAMBIO DE Bank0
    CLRF PORTA          ; INICIALIZO EL PORTD
			; LIMPIO EL REGISTRO
			; data latches
    BSF STATUS, RP0     ; Select Bank 1
    MOVLW 0x06          ; Configure all pins
    MOVWF ADCON1        ; as digital inputs
    MOVLW 0xCF          ; Value used to
			; initialize data
			; direction
    MOVWF TRISD         ; Set RD<3:0> as inputs
			; RD<5:4> as outputs
			; TRISD<7:6>are always
			; read as '0'.
;PUERTO E
    
    BCF STATUS, RP0     ;
    BCF STATUS, RP1     ; CAMBIO DE Bank0
    CLRF PORTA          ; INICIALIZO EL PORTE
			; LIMPIO EL REGISTRO
			; data latches
    BSF STATUS, RP0     ; Select Bank 1
    MOVLW 0x06          ; Configure all pins
    MOVWF ADCON1        ; as digital inputs
    MOVLW 0xCF          ; Value used to
			; initialize data
			; direction
    MOVWF TRISE         ; Set RE<3:0> as inputs
			; RA<5:4> as outputs
			; TRISE<7:6>are always
			; read as '0'.
 ;CONFIG DE INTERRUPCIONES Y MODULOS
 
 
MAIN:
    ;CALL NIVEL_DE_AGUA
    
    ;CALL PRESION_CALLE
    
    ;CALL BOMBA_PWM
    ;DEPENDIENDO DEL MENSAJE Y EL NIVEL DEL TANQUE O DEL NIVEL DEL TANQUE Y SI ESTA EN MANUAL, TIPO PRIMERA MANUAL O AUTOMATICO DESPUES NIVEL DE TANQUE 1 Y 2 DESPUES PRENDO O APAGO
    ; EL PIC 1 SABE CUANDO ESTA EN MANUAL Y CUANDO APAGARIA POR NIVEL BAJO O POR BLOQUEO, PERO EN MANUAL COMO SABE PIC 1 QUE PIC 2 ESTA LLENO SI NO HAY COM SERIAL?
    ;POR SOFTWARE ABRIA QUE MANTENER LA COM SIEMPRE ANALOGICAMENTE UN FLOTANTE O UN PRESOSTATO HACE EL TRABAJO, ENTONCES PODRIAMOS OBVIAR ES
    
    ;PARA APAGARLA HAY QUE COMUNICARSE VIA SERIAL PARA QUE EL PIC 1 SEPA CUANDO APAGAR
    
    ;CALL COM_SERIAL
    
    ;CALL 
    
    
    
    
    ;CREO QUE TIENES RAZON QUE UTILIZANDO SOLO EL ADC PODEMOS DIRIGIR TODO EL PROGRAMA
    ; Y EN REALIDAD ESE ES EL MENU, QUE CRACK DE PANA, TIPO QUE AJA SABIENDO EN QUE NIVEL ESTAS SABES A DONDE VAS A IR Y ES TU CICLO INFINITO
    

    
PRESION_CALLE:

COM_SERIAL:

BOMBA_PWM:

MANUAL:

NIVEL_DE_AGUA:


	

END