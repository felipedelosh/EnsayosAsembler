; Se desea hacer una rutina dado un numero que entra por el puertoB
; retorne cierto valor que hay en una tabla
    
    
org 0x0
    
    
    ; Habilita el portb Como entrada
    movlw 0x86
    movwf 0x04 ; >>fsr apunta a trisB
    movlw .255
    movwf 0x0 ; PuertoB es entrada
    
    
    ; Habilira el porta como salida
    movlw 0x87
    movwf 0x04 ; >>fsr >> trisC
    clrw
    movwf 0x0 ; puertoC es salida
    
    ; Se hace la rutina que comprueba la entrada
    input:
    ; Procedo a limpiar el puertoC
    clrw
    movlw 0x07
    call nrosPrimos
    ; Mando el primo al porcC
    movwf 0x07
    goto input
    
    
    
    nrosPrimos:
    ; capturo lo que hay en portB lo guardo en aku
    movf 0x06, 0
    ; PortB + PCL y brinca
    addwf 0x02, 1
    retlw .2
    retlw .3
    retlw .5
    retlw .7
    retlw b'00010001'
    
    
    retlw b'00010011'
    retlw b'00010111'
    retlw b'00011001'
    retlw b'00110111'
    retlw b'00111001'
    
    retlw b'00110001'
    retlw b'00110111'
    retlw b'01000001'
    retlw b'01000111'
    retlw b'01010011'
    
    retlw b'01011001'
    
    
    
    
    
end