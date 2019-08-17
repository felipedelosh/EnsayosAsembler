; Parcial de micros
    
org 0x0
goto main
    
org 0x4
goto porTres
    
    
   main:
   ; --------------------------------------------------------------
   ; --------------------------------------------------------------
   ; --------------------------------------------------------------
   ; Procedo a guardar la wea con direccionamiento indirecto
   ; el registro 0x20 controla las veces que se hace el for
   movlw .7
   movwf 0x20
   ; El registro 0x21 controla la pos en la que se va a escribir
   movlw 0xA1
   movwf 0x21
   ; El registro 0x22 controla el numero que se va a escribir //potencia de 2
   movlw .2
   movwf 0x22
   
   ; Nota el corrimiento solo funciona apartir de 2 por ello empiezo ahi
   
    ; Aka hay un for
    etiqueta:
    ;Cuerpo FOR
   
    ; Procedo a capturar lo que diga 0x21
    movf 0x21, 0
    ; procedo a mandar la wea al fsr
    movwf 0x04
    ; procedo a mandarle el valor : potencia de 2
    movf 0x22, 0
    ; Procedo a guardar esa wea en la dir requerida
    movwf 0x0
    ; Procedo a incrementar la dir requerida // Nuevo espacio
    incf 0x21, 1
    ; Procede a aumentar la potencia de 2
    bcf 0x03, 0 ; Procedo a limpiar el carry
    rlf 0x22, 1
    DECFSZ 0x20, 1
    goto etiqueta
    ; En este momento las potencias de 2 han sido guardadas en A0 a A7
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    
    
    
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; Procedo a poner el puertoA como entrada
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
    ; En este momentos los bits menos significativos del puertoA son de entrada
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    
    
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; Nota: esta wea tiene interrupciones
    ; Procedo a configurar pin0 puertoB como entrada
    movlw 0x86
    movwf 0x04 ; fsr >> trsiB
    movwf .255 ; todas por si las moscas
    movwf 0x0 ; portB como entrada
    ; Procedo a habilitar las resistencias de pull-up
    ; voy al banco 1
    bsf 0x03, 5
    bcf 0x03, 6
    ; pongo en 0 el pull up
    bcf 0x81, 7
    ; voy para el banco 0
    bcf 0x03, 5
    bcf 0x03, 6
    ; Procedo a limpiar el puertoB
    movlw .0
    movwf 0x06
    ; Esto hace que el puerto pueda ser leido
    movf 0x06, 1
    ;Procedo a habilitar el portB como entrada de interrupcion
    bsf 0x0B, 7
    bcf 0x0B, 0
    bsf 0x0B, 3
    
   

    
    
    
    
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; Procedo a configurar el puertoC como puerto de salida
    movlw 0x87
    movwf 0x04 ; fsr >> trisC
    movlw .0
    movwf 0x0 ; el puertoC es de salida en estos momentos
    ; En estos momentos el puertoC es un puerto de salida
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    
    
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; Nota: para que esta wea rote las potencias se necesita un registro
    ; que controle la iteracion de rotacion 0x7f
    restart:
    movlw 0xA0
    movwf 0x7f
    ; Nota: se necesita saber cuando la wea tiene que parar 0x7E // Konstant
    movlw 0xA7
    movwf 0x7e
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; Nota: aka se hace por ahi que el tiempo sea 3 veces mayor
    ; hagamos que 0x7D controle esa wea
    movlw .0
    movwf 0x7D
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    ; --------------------------------------------------------------
    
    
    capturarA:
    ; Procedo a capturar lo que diga 0x7f // iterator
    movf 0x7f, 0 ; aku sabe que mostrar
    movwf 0x04 ; fsr ya sabe quien mostrar
    movf 0x0, 0 ; ya le pregunte a fsr a quien mostrar
    ; Muestro esa wea
    movwf 0x07
    ; ya mostre la potencia de 2
    ; Procedo a calcular el retardo que tiene 
    ; Sera que el wey puso 00 en puertoA
    ; procedo a capturar lo que hay en portA>>aku
    movf 0x05, 0
    ; si hay un 00 stop
    sublw .0
    ; si hay status.z = 0 
    btfsc 0x03, 2
    goto timeSTOP
    ; Sera que el wey puso 01 en puertoA
    ; procedo a capturar lo que hay en portA>>aku
    movf 0x05, 0
    sublw b'01'
    ; si hay status.z = 0 
    btfsc 0x03, 2
    call timeUNO
    ; Sera que el wey puso 10 en puertoA
    ; procedo a capturar lo que hay en portA>>aku
    movf 0x05, 0
    sublw b'10'
    ; si hay status.z = 0 
    btfsc 0x03, 2
    call timeDOS
    ; Sera que el wey puso 11 en puertoA
    ; procedo a capturar lo que hay en portA>>aku
    movf 0x05, 0
    sublw b'11'
    ; si hay status.z = 0 
    btfsc 0x03, 2
    call timeTRES
    ; Nota: tal vez esa wea se desbordo calibremosla
    ; 0x7e - 0x7f = 0
    movf 0x7f, 0
    subwf 0x7e, 0
    btfsc 0x03, 2
    goto restart
    ; Los tiempos fueron calculados ahora procedo a mostrar la otra potencia
    incf 0x7f, 1
    goto capturarA
    
    
    timeSTOP:
    movlw .0
    movwf 0x7D
    goto capturarA
    
    timeUNO:
    movlw .1
    movwf 0x7D
    call CasiSegundo
    return
    
    timeDOS:
    movlw .2
    movwf 0x7D
    call CasiSegundo
    call CasiSegundo
    return
    
    timeTRES:
    movlw .3
    movwf 0x7D
    call CasiSegundo
    call CasiSegundo
    call CasiSegundo
    return
    
    
    
    ; Este metodo fue echo a lo bestia//yo creo que es 1 segundo
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
    
    porTres:
    ;Procedo a desabilitar la interrupcion
    bcf 0x0B, 0
    ; Procedo a hacer los calculos
    ; No alcanzo el tiempo:
    ; hacer un ciclo 3 veces dependiendo de lo que diga0x7D
    ; Y el problema era como hacer que el programa continue de la iteracion
    movlw 0xAA
    movwf 0x07
    retfie
    
    
end