; crear una rutina que por el puerto c muestre de 0 a 15
; que en el bit menos significativo se conecte un punsador... y	
; que pare durante 3 segundos y luego siga contando.
    
  
    
org 0x00
goto main
org 0x04
call esperar
 
main:
    ; Procedo a habilitar b0 como control de interrupcioes
    bsf 0x0b, 7
    bsf 0x0b, 4
    bcf 0x0b, 1
    ; Procedo a habilitar el puerto C como salida
    movlw 0x87
    movwf 0x04 ; >>fsr apunta a trisc
    movlw .0
    movwf 0x00 ; ; trisC=.255
    ; El registro 0x20F cuenta hasta 15
    movlw .0
    movwf 0x2f
    ; contar desde 0 hasta 15
    ; Condicion del for i=0 to 15 do:
    ; El ciclo lo quiero hacer 16 veces por ello guardo 16 en .32
    movlw .15
    movwf 0x20
    ; creo una etiqueta para el ciclo
    etiqueta:
    ; Procedo a incrementar
    incf 0x2f, 1
    ; Procedo a mandar eso a portC
    movf 0x2f, 0
    movwf 0x07
    goto CasiSegundo
    continue:
    ;Fin for 
    DECFSZ 0x20, 1
    goto etiqueta
    goto main
    
    
esperar:
    ; Limpio para que la interrupcion no se llame muchas veces
    bcf 0x0b, 1
    ; Ciclo principal
	; Primer Ciclo
	movlw .40
	movwf 0x60
	cicloA:
	    ; segundo ciclo 
	    movlw .120
	    movwf 0x61
	    cicloB:
		; tercer ciclo
		movlw .250
		movwf 0x62
		    cicloC:
		    decfsz 0x62, 1
		    goto cicloC
	    decfsz 0x61, 1
	    goto cicloB
	decfsz 0x60, 1
	goto cicloA
    goto continue
 
    
CasiSegundo:
    ; Ciclo principal
	; Primer Ciclo
	movlw .13
	movwf 0x70
	ciclo1:
	    ; segundo ciclo 
	    movlw .90
	    movwf 0x71
	    ciclo2:
		; tercer ciclo
		movlw .255
		movwf 0x72
		    ciclo3:
		    decfsz 0x72, 1
		    goto ciclo3
	    decfsz 0x71, 1
	    goto ciclo2
	decfsz 0x70, 1
	goto ciclo1
    
    goto continue
    
    
    
    
end