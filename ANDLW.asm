; Analisis de ADDWF
    
; Dada una pocion de memoria se suma al aku y se puede guardar en?
    
    
    
org 0x00
    
    ;Primero se carga algo a W
; Analisis de ANDLW
    
    
org 0x00
    
    ; Procedo a cargar el aku con 00110101
    movlw .53
    
    ; Procedo a hacer and con 00001001
    ANDLW .9
    
    ;miro el resultado en 0x20
    movwf 0x20
    
end