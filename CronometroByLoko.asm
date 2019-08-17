; Hacer un cronometro
; pic a 4Mhz
    
org 0x0
    
    ; Inizializar el TMR0 0x01
    movlw .156
    movwf 0x01
   
    
    tiempoAvanza:
    
    ; El registro 0x20 controla el conteo:
    incf 0x20, 1
    
    
    goto tiempoAvanza
    
    
end
