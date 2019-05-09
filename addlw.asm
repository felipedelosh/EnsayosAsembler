; Analisis de ADDLW
    
    
    
org 0x00
    
    ;Primero se carga algo a W
    movlw 0x00; pongo el aku en 0
    addlw .255; le sumo al aku 255
    
    movwf .32; copio lo del aku al 0x20
    
end