; Configurar Una Manguera led
; Usar cualquier entrada de porta con un swicht 
; Si prees >> si no pres <<
org 0x0
   
    ; Configurar PortB Y PortC como salida
    ; trisB > 0
    movlw 0x86 
    movwf 0x04 ; fsr >> trisB
    movlw 0x0
    movwf 0x0 ; TrisB>PortB salida
    
    ;TrisC > 0
    movlw 0x87
    movwf 0x04 ; fsr >> TrisC
    movlw 0x0
    movwf 0x0 ; trisC >> PortC salida
    ; Los puertos b y c son de salida
    
    ; Procedo a configurar puerto A como entrada digital
    ; Adcon1 .7
    movlw 0x9f ; voy a apuntar a adcon
    movwf 0x04 ; fsr > Adcon1
    movlw .7
    movwf 0x0 ; Adcon es .7 PortA in digital
    
    ; TrisA > 0
    movlw 0x85
    movwf 0x04 ; fsr > trisA
    movlw .63 
    movwf 0x0 ; Pin PortA entrada digital
    
    
    
    
    
    
    
    
    rutina:
    
    movlw 0xFF
    btfsc 0x05, 3
    goto irA
    goto irB
    
    
    
    irA:
    ; Apago los portBC
    movlw 0x0
    movwf 0x06
    movwf 0x07
	
	; For i=0 to 8 do >> 
	; i controlado por .2f
	movlw .8
	movwf 0x2f
	; El corrimiento sera controlado por 0x20
	movlw .1
	movwf 0x020
	cicloAA:
		 
	movf 0x20, 0 ; cargo a AKU
	; Procedo a limpiar carry
	bcf 0x03, 0
	movwf 0x06 ; mando a portB
	; Procedo a correr la direccion 0x20
	call CasiSegundo
	rlf 0x20, 1
	DECFSZ 0x2f, 1
	goto cicloAA
	
	; Procedo a limpiar el puertoC
	clrw
	movwf 0x06
	

	; For i=0 to 8 do >> 
	; i controlado por .2f
	movlw .8
	movwf 0x2f
	; El corrimiento sera controlado por 0x20
	movlw .1
	movwf 0x020
	cicloAB:
	movf 0x20, 0 ; cargo a AKU
	; Procedo a limpiar carry
	bcf 0x03, 0
	movwf 0x07 ; mando a portB
	; Procedo a correr la direccion 0x20
	rlf 0x20, 1
	call CasiSegundo
	DECFSZ 0x2f, 1
	goto cicloAB
	
    goto finrutina
    
    irB:
    ; Apago portB Y portC
    movlw 0x0
    movwf 0x06
    movwf 0x07
    
        ; For i=0 to 8 do >> 
	; i controlado por .2f
	movlw .8
	movwf 0x2f
	; El corrimiento sera controlado por 0x20
	movlw b'10000000'
	movwf 0x020
	cicloBB:
	
	movf 0x20, 0 ; cargo a AKU
	; Procedo a limpiar carry
	bcf 0x03, 0
	movwf 0x07 ; mando a portC
	; Procedo a correr la direccion 0x20
	rrf 0x20, 1
	DECFSZ 0x2f, 1
	goto cicloBB
	
	; procedo a limpiar el puerto C
	movlw .0
	movwf 0x07
	
	; Procedo a ir al otro banco de memoria
	; for 0..8
	movlw .8
	; 0x2f controlara el ciclo
	movwf 0x2f
	; el corriento debe de empezar 00000001
	movlw b'10000000'
	movwf 0x20
	cicloBC:
	movf 0x20, 0; cargo al aku
	; procedo a limpiar el carry
	bcf 0x03, 0
	movwf 0x06 ; mando a portB
	; Procedo a correr
	rrf 0x20, 1
	decfsz 0x2f, 1
	goto cicloBC
    
    goto finrutina
    
    
    
    finrutina:
    goto rutina
    
    
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