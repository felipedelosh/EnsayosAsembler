; Conectar un teclado matricial a portB 
; mostrar lo indicado en portC
    
org 0x0
goto main
    
org 0x4
goto pintarNumero
   
    
    main:
    ; Resistor pull up 0
    ; voy al banco 1
    bsf 0x03, 5
    bcf 0x03, 6
    ; pongo en 0 el pull up
    bcf 0x81, 7
    ; voy para el banco 0
    bcf 0x03, 5
    bcf 0x03, 6
    
    
    
    
    ; Pongo portB como salida, entrada
    movlw 0x86
    movwf 0x04 ; fsr >> trisB
    movlw b'11110000'
    movwf 0x0 ; portB in out
    
    ; pongo portC como salida
    movlw 0x87
    movwf 0x04 ; fsr >> trisC
    movlw b'11110000'
    movwf 0x0
    ; Procedo a limpiar portc
    movlw .0
    movwf 0x7
    
    ; Esto hace que el puerto pueda ser leido
    movf 0x06, 1
    
    ;Procedo a habilitar el portB b4 a b7 como entrada de interrupcion
    bsf 0x0B, 7
    bcf 0x0B, 0
    bsf 0x0B, 3
    
    
    captura:
    ; Procede a circular el 0
    movlw b'1110'
    movwf 0x06
    movlw b'1101'
    movwf 0x06
    movlw b'1011'
    movwf 0x06
    movlw b'0111'
    movwf 0x06
    goto captura
    
    
    pintarNumero:
    ; Capturo el puertoB
    movf 0x06, 0
    movwf 0x20
    ;Procedo a desabilitar la interrupcion
    bcf 0x0B, 0
    ; Nota: el valor presionado esta contenido en 0x20
    movf 0x20, 0
    sublw b'11101011'
    ; si el numero presionado es 0
    btfsc 0x03, 2
    call pintarTres
    movf 0x20, 0
    ; Si el numero presionado es 1
    sublw b'11010111'
    btfsc 0x03, 2
    call pintarUno
    
    goto pintarA
    retfie
    
    pintarCero:
    movlw .0
    movwf 0x07
    return
    
    pintarUno:
    movlw .1
    movwf 0x07
    return
    
    pintarDos:
    movlw .2
    movwf 0x07
    goto captura
    
    pintarTres:
    movlw .3
    movwf 0x07
    goto captura
    
    pintarCuatro:
    movlw .4
    movwf 0x07
    goto captura
    
    pintarCinco:
    movlw .5
    movwf 0x07
    goto captura
    
    pintarSeis:
    movlw .6
    movwf 0x07
    goto captura
    
    pintarSiete:
    movlw .7
    movwf 0x07
    goto captura
    
    
    pintarOcho:
    movlw .8
    movwf 0x07
    goto captura
    
    pintarNueve:
    movlw .9
    movwf 0x07
    goto captura
    
    pintarA:
    movlw 0xA
    movwf 0x07
    goto captura
 
    
end