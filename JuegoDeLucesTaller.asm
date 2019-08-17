;realizar un juego de luces.
;conectadas al puertoB cuaya secuencia dependera de unos interruptores
;conectados al puerto A

;a -> si in 00 las luces deben de estar apagadas
;b -> si in 01 los leds deben de parpadear lag 1 seg
;c -> si in 10 los leds deben de dar un recorrido de der a izq
;c -> si in 11 los leds daran un recorrido de izq a der
    
org 0x0
    
    ; activo el puertoA como entrada digital
    ; mandarle un .7 al adcon1 
    movlw 0x9f
    movwf 0x04 ; >>fsr adcon1
    movlw .7
    movwf 0x0 ; >> puerto a entrada digital
    
    ; voy a decirle al trisA 0 y 1 son entradas
    movlw 0x85
    movwf 0x04 ; fsr>>trisA
    movlw b'11'
    movlw 0x0 ;>> portA(0,1) entrada
    

    ; voy a activar el puertoB como salida
    movlw 0x86
    movwf 0x04 ; >> fsr>>trisB
    movlw .0
    movwf 0x0 ; portB es salida
    
    ; Procedo a apagar portB
    movlw 0x0
    movwf 0x6
    

    capturarA:
    ; procedo a capturar lo que hay en portA>>aku
    movf 0x05, 0
    ; si hay un cero en aku apago las luces
    sublw .0
    ; si hay status.z = 0 
    btfsc 0x03, 2
    goto apagarLuces
    ; No hay 00 en aku por ello sera que hay 01?
    movf 0x05, 0 ; procedo a capturar lo que hay en portA>>aku
    sublw b'1'
    btfsc 0x03, 2
    goto parpadearTodos1seg
    ; No hay 01 en aku por ello sera que hay 10?
    movf 0x05, 0 ; procedo a capturar lo que hay en portA>>aku
    sublw b'10'
    btfsc 0x03, 2
    goto recorrDERIZQ
    ; no hay 10 en aku entonces tiene que haber un 11
    goto recorrIZQDER
    ; Las sub-rutinas ya se encargan de llamar al programa
    
    
    
    ;00
    apagarLuces:
    movlw .0
    movwf 0x06
    goto capturarA
    
    
    ;01
    parpadearTodos1seg:
    ; Procedo a encender todos los LED 
    movlw .255
    movwf 0x06 ; todos los de portB encendidos
    ; Procedo a esperar 1 segundo
    call CasiSegundo
    ; Procedo a apagar todos los leds
    movlw .0
    movwf 0x06 ; todos los de portB apagados
    ; Procedo a esperar 1 segundo
    call CasiSegundo
    goto capturarA
    
    
    ;10
    recorrDERIZQ:
    
	movlw b'10000000'
	; el reg 0x21 me va a guardar eso
	movwf 0x21
	; procedo a apagar el portB
	movlw .0
	movwf 0x06
	
	    ; Condicion del for i=0 to 10 do:
	    ; El ciclo lo quiero hacer 7 veces por ello guardo 8 en 0x20
	    movlw .8
	    movwf 0x20
	    ; creo una etiqueta para el ciclo
	    forA:
	    ; Sumo el 2 que hay en aku en .33
	    ;Cuerpo FOR
	    ;------------------------------
	    ;capturo lo que hay en 0x21
	    movf 0x21, 0
	    ; mando esa wea al portB
	    movwf 0x06
	    ; Procedo a hacer el corrimiento der izq
	    bcf 0x03, 0 ; Procedo a limpiar el carry
	    rrf 0x21, 1
	    ; Espero 1 segundo 
	    call CasiSegundo
	    ;------------------------------
	    ;Fin for 
	    DECFSZ 0x20, 1
	    goto forA
	
    
    goto capturarA
    
    
    ;11
    recorrIZQDER:
    
	movlw b'00000001'
	; el reg 0x21 me va a guardar eso
	movwf 0x21
	; procedo a apagar el portB
	movlw .0
	movwf 0x06
	
	; Condicion del for i=0 to 10 do:
	; El ciclo lo quiero hacer 7 veces por ello guardo 8 en 0x20
	movlw .8
	movwf 0x20
	; creo una etiqueta para el ciclo
	forB:
	; Sumo el 2 que hay en aku en .33
	;Cuerpo FOR
	;------------------------------
	;capturo lo que hay en 0x21
	movf 0x21, 0
	; mando esa wea al portB
	movwf 0x06
	; Procedo a hacer el corrimiento der izq
	rlf 0x21, 1
	bcf 0x03, 0 ; Procedo a limpiar el carry
	; Espero 1 segundo 
	call CasiSegundo
	;------------------------------
	;Fin for 
	DECFSZ 0x20, 1
	goto forB
    
    goto capturarA
    
    
    
    
    
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