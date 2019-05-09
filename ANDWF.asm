; Analisis de la instruccion ADDWF
    
org 0x0
    
   
   
   
   ; procedo a poner el registro 0x20 en 01000000
   movlw .64
   movwf 0x20
   
   ;Procedo a borrar el akumulador
   CLRW
   
   ;Pongo el aku en 01100101 
   movlw .101
   
   ;Procedo a hacer AND y guardarlo en aku
   ANDWF .32, 0
   
   ; Si le pongo 0 se guarda en aku
   ; Si le pongo 1 se guarda en el registro
   
   ;Muestro en 0x20
   movwf 0x20
    
    
end