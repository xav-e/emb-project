;**************** THE WELS THEORY ******************
;Descripci�n: Encendido de LEDS del puerto RB3 y RB4
;Para m�s informaci�n visita: www.thewelstheory.com
;Y sigueme en www.facebook.com/WelsTheory
    
List P=16F84A ; Procesador PIC16f84A
#include "p16f84a.inc" ;Incluye las librerias 
    
; CONFIGURACION DEL PIC16F84A
 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_ON & _CP_OFF
 
;CODIGO
 
    ORG 0; Direccion 0 del Programa
INICIO
    BSF	   STATUS,RP0 ;SELECCIONAR EL BANCO 1
    CLRF   TRISB; PORTB COMO SALIDA
    BCF	   STATUS,RP0; SELECCIONAMOS EL BANCO 0
    
START
    MOVLW  B'00011000'; 8BITS -> W
    MOVWF  PORTB; W -> PORTB. RB0 - RB7
    GOTO   START
    END
