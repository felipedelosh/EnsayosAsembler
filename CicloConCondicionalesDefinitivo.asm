;leer portb
; se particionara en 2 numeros el puertb A:[7,6,5,4] B:[3,2,1,0]
; luego hacer una rutina que compare cual es mayor
; luego el numero mayor
    
    
    
org 0x0
    
    ; pongo trisb en .255 para que todos funcionen como entrada
    ; trisb esta en 0x86
    
    ; voy a apuntar al trisb con fsr
    movlw 0x86
    movwf 0x04 ; fsr apunta a trisb
    ; aku sera 11111111
    movlw .255
    movwf 0 ; pongo trisb en FF
    
    ; Pongo trisc 00000000 para que todos funcionen como salida
    ; trisc esta en 0x87
    
    ; voy a apuntar al trisc con fsr
    movlw 0x87
    movwf 0x04 ; fsr apunta a trisc
    ; aku sera 0000000
    clrw
    movwf 0 ; trisc va a ser 00000000
    
    ; ya se configuro lo referente a entradas y salidas 
    ; se hace un ciclo que siempre compare los numeros
    
    compare:
    
    ; cargo al akumulador lo que tenga portb
    movf 0x06,0 ; aku contiene todo portb
    ; guardo esa wea en registros .32 y .33
    movwf .32 ; aqui quiero guardar los primeros 4 bit ????xxxx
    movwf .33 ; aqui quiero guardar los ultimos 4 bit xxxx????
    ; voy a borrar los primeros 4 bit de .32 con un and 11110000
    ; guardo 11110000 en aku
    movlw b'11110000'
    ; voy a hacer and y guardarlo en .32
    ; luego voy a intercambiar esosnumeros ????xxxx -> xxxx????
    andwf .32, 1
    swapf .32, 1
    ; fin de guardar el primer numero
    
    ; cargo el akumulador con 00001111
    movlw b'00001111'
    ; voy a hacer and y guardarlo en .33
    andwf .33, 1
    ; no hay que hacer swapf ya esta en estos momentos en xxxx????
    ; los dos numeros fueron guardados correctamente en .32 y .33
    
    
    ; para saber quien es mas grande se hace una resta...
    ; w.32 - .33 
    ; si (w.32 - .33) == 0 son iguales muestra.32 bit 7 en cero
    ; si (w.32 - .33) > 0 .32 es mayor se muestra .32 bit 7 en cero
    ; si (w.32 - .33) < 0 .33 es mayor se muestra .33 bit 7 en uno
    
    ; cargo .33 al aku
    movf .33, 0
    ; hago la resta con .32
    subwf .32, 0
    ; mando el resultado de aku a .34
    movwf .34
    
    ; comparo 7 bit para saber si es negativo
    btfss .34, 7
    goto noneg
    goto esneg
    
    esneg:
    ; (w.32 - .33) < 0
    movf .33, 0
    movwf 0x07
    goto fincompare
    
    noneg:
    ;(w.32 - .33) >= 0
    movf .32, 0
    movwf 0x07
    goto fincompare
    
    fincompare:
    ; se repite infinitamente
    goto compare
     
end