; Analisis de ADDWF
    
; Dada una pocion de memoria se suma al aku y se puede guardar en?
    
    
    
org 0x00
    
    ;Primero se carga algo a W
    movlw 0x01; pongo el aku en 1
    
    ;el uno que hay en el aku procedo a mandarlo a reg 0x20
    movwf .32
    ;procedo a borrar el akumulador
    CLRW 
    
    ;Procedo cargando otra cosa en aku
    movlw 0x02; pongo el aku en 2
    
    ;el dos que hay en aku procedo a moverlo en 0x21
    movwf .33
    
    ;borro el aku
    CLRW
    
    ; Cargo 0x09 al aku
    movlw 0x09
    
    
    ;Procedo a sumar aku con 0x20 y lo guardo en 0x20
    addwf .32, 1
    ;Procedo a sumar aku con 0x21 y guardarlo en el akumulador
    addwf .33, 0
    
    ;procedo a mostrar la suma de .33+W >> .34
    movwf .34
     
    
end