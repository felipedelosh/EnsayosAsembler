; leer el puertoB [0,3][4,7]
; leer los bits menos significativos del puertoC
; 00 suma
; 01 resta
; 10 and
; 11 or
    
org 0x0
   
    ; 1 - configurar el puertoB como entrada
    movlw 0x86 ; trisb
    movwf 0x04 ; fsr >> trisb
    movlw .255
    movwf 0x0 ; portb entrada
    
    
    ; 2 - configurar el puertoC [0, 3] salida, [4, 7] entrada >> 4;5 in
    movlw 0x87 ; trisc
    movwf 0x04 ; fsr >> trisc
    movlw b'00001111'
    movwf 0x0 ; portc in out
    
    ; 3 - procedo a limpiar el puertoc
    movlw .0
    movwf 0x07
    
    
    captura:
    ; capturo el puertoB lo guardo en aku
    movf 0x06, 0
    ; Me interezan solo los 4 primeros bit
    andlw b'00001111'
    ; Procedo a guardarlos
    movwf 0x20 ; guardado portB[0, 3]
    ; capturo el puertoB
    movf 0x06, 0
    ;guardo en 0x21 para intercambiarlos
    movwf 0x21
    ; intercambio y guardo en aku
    swapf 0x21, 0
    ; Me interezan solo los 4 primeros bit
    andlw b'00001111'
    ; procedo a guardarlo en 0x21
    movwf 0x21
    ; --------------------------------------------------
    ; --------------------------------------------------
    ; Procedo a capturar el puertoC
    movf 0x07, 0
    ; solo me intereza los 2 primeros bit
    andlw b'00000011'
    ; Sera que hay 00?
    sublw b'00000000'
    btfsc 0x03, 2 ;Si no es ese numero prosiga
    goto suma
    ; No es 00 sera que es 01
    movf 0x07, 0
    andlw b'00000011'
    sublw b'00000001'
    btfsc 0x03, 2 ;Si no es ese numero prosiga
    goto resta
    ; No es 01 sera que es 10?
    movf 0x07, 0
    andlw b'00000011'
    sublw b'00000010'
    btfsc 0x03, 2 ;Si no es ese numero prosiga
    goto haigaand
    ; Si no es gallo es por que es gallina
    goto haigaor
 
   
    suma:
    ; La primera parte esa contenida en 0x20 capturo en aku
    movf 0x20, 0
    ; lo sumo a la segunda parte contenida en 0x21 guardo en aku
    addwf 0x21, 0
    ; el reg 0x22 me va a guardar el resultado
    movwf 0x22
    swapf 0x22, 1 ; Hay que intercambiar la wea
    movf 0x22, 0
    movwf 0x07
    goto captura
    
    
    resta:
    ; Aca se va a restar A-B >> f-w >0x22
    ; capturo 0x21 en aku
    movf 0x21, 0
    ; resto lo que hay en 0x20
    subwf 0x20, 0
    ; el reg 0x22 me va a guardar el resultado
    movwf 0x22
    swapf 0x22, 1
    movf 0x22, 0
    movwf 0x07
    goto captura
    
    
    haigaand:
    ; Aca se va a hacer A and B
    ; capturo 0x20 en aku 
    movf 0x20, 0
    ; Hago and con 0x21 guado en aku
    andwf 0x21, 0
    ; el reg 0x22 me va a guardar el resultado
    movwf 0x22
    swapf 0x22, 1
    movf 0x22, 0
    movwf 0x07
    goto captura
    
    haigaor:
    ; Aca se va a hacer A ord B
    ; capturo 0x20 en aku 
    movf 0x20, 0
    ; Hago and con 0x21 guado en aku
    iorwf 0x21, 0
    ; el reg 0x22 me va a guardar el resultado
    movwf 0x22
    swapf 0x22, 1
    movf 0x22, 0
    movwf 0x07
    goto captura
    
    
    
end