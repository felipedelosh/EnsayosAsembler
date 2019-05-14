; hacer un ciclo que guarde los numeros consecutivos 1 ... 10
; apartir de 0x20 hasta 0x29
    
org 0x00
    
    ; guardo en 0x30 las diez veces que se va a ejecutar
    movlw .10
    movwf 0x30
    
    ; pongo el fsr en 0x20
    movlw 0x20
    ; lo guardo en fsr >> Puntero de direccionamiento indirecto
    movwf 0x04
    
    ;pongo 1 en 0x31
    movlw .1
    movwf 0x31
    
    ; Hago un ciclo
    etiqueta:
    ;incremento la pos 0x31
    incf 0x31, 1
    movf 0x31, 0
    movwf 0
    ; eso ya se guardo entonces incremento fsr
    incf 0x04, 1
    decfsz 0x30, 1
    goto etiqueta
    
end 