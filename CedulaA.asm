; Guardar los digitos de la cedula en tabla
; mostrar esa wea por el puertoC
; conectar un pulsador al puertoB que invierta el orden en que se muestra
    
org 0x0
goto main
    
org 0x4
goto mostrarB
    
    
    
    ;habilito el puertoC como salida
    movlw 0x87 ; trisc
    movwf 0x04 ; fsr >> trisc 
    movlw .0
    movwf 0x0
    
    ; Habilitar 1 pin del puertoB
    movlw 0x86
    movwf 0x04 ; fsr >> trisB
    movlw b'00000001'
    movwf 0x0
    
    ; Limpio el puertoB
    movlw .0
    movwf 0x06
    
    reiniciarIndicador:
    ; el registro 0x20 coniene el digito cursado
    movlw .0
    movwf 0x20
    ; El registro  0x23 contiene el digito cursado en reversa
    movlw .10
    movwf 0x23
    ; el registro  0x21 contiene el limite 
    movlw .10
    movwf 0x21
    
    
    mostrarA:
    call tabla
    ; ya se que digito sigue por ello procedo a mostrarlo
    movwf 0x07
    ; espero 1 segundo
    call CasiSegundo
    ; la pos 0x20 aumenta
    incf 0x20, 1
    ; En caso de que 0x20 - 0x21 = 0 reinicio
    movf 0x20, 0
    subwf 0x21, 0
    btfsc 0x03, 2
    goto reiniciarIndicador
    goto mostrarA
    
    
    
    mostrarB:
    
    goto mostrarB
  
    
    tabla:
	; Procedo a capturar lo que hay en 0x20
	movf 0x20, 0
	; PortB + PCL y brinca
	addwf 0x02, 1
	retlw .1
	retlw .0
	retlw .5
	retlw .9
	retlw .7
	retlw .8
	retlw .5
	retlw .5
	retlw .1
	retlw .7
	
	
	
	

    ;Esta es la funcion de retardo
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
    
    return
end