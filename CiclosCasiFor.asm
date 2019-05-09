; Como hacer un ciclo
    
    
; Procedo a hacer un ciclo que sume 2 al reg .33
    
org 0x0
    
    ; Guardo 0 en el registro .33
    movlw .0
    movwf .33
    
    ; Condicion del for i=0 to 10 do:
    ; El ciclo lo quiero hacer 10 veces por ello guardo 10 en .32
    movlw .10
    movwf 0x20
    
    ; Pongo en 2 el aku
    movlw .2
   
    ; creo una etiqueta para el ciclo
    etiqueta:
    ; Sumo el 2 que hay en aku en .33
    ;Cuerpo FOR
    addwf .33, 1
    ;Fin for 
    DECFSZ 0x20, 1
    goto etiqueta
      
end 