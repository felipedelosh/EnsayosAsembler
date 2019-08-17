; portb b[0, 3] = out; b[4, 7] = in 
; conectar un teclado 16 y mostrar en un 7 segmentos
    
org 0x0
goto main
    
org 0x4
goto display
    
    
; rutina principal
main:
    ; Resistor pull up 0
    ; voy al banco 1
    bsf 0x03, 5
    bcf 0x03, 6
    ; pongo en 0 el pull up
    bcf 0x81, 7
    ; voy para el banco 0
    bcf 0x03, 5
    bcf 0x03, 6
    
    
    
    ; pongo portb out in
    movlw 0x86
    movwf 0x04 ; fsr>>trisb
    movlw b'11110000'
    movwf 0x0 ; portB in out

   ;Habilito el portc como salida
   movlw 0x87
   movwf 0x04; fsr>>trisc
   movlw .0
   movwf 0x0 ; portC salida
   ; procedo a apagarlos
   movwf 0x07
   
   ;Procedo a habilitar el portB b4 a b7 como entrada de interrupcion
   bsf 0x0B, 7
   bcf 0x0B, 0
   bsf 0x0B, 3
   
   
   ;Estas variables controlan que tecla quiere ser presionada para ello solo 
   ; basta con hacer una resta 
   ; 60 a 6E controla eso
   movlw b'11100111';0
   movwf 0x60
   movlw b'11010111';1
   movwf 0x61
   movlw b'10110111';2
   movwf 0x62
   movlw b'01110111';3
   movwf 0x63
   movlw b'11111111';4
   movwf 0x64
   movlw b'11111111';5
   movwf 0x65
   movlw b'11111111';6
   movwf 0x67
   movlw b'11111111';7
   movwf 0x66
   movlw b'11111111';8
   movwf 0x68
   movlw b'11111111';9
   movwf 0x69
   movlw b'11111111';10
   movwf 0x6A
   movlw b'11111111';11
   movwf 0x6B
   movlw b'11111111';12
   movwf 0x6C
   movlw b'11111111';13
   movwf 0x6D
   movlw b'11111111';14
   movwf 0x6E
   movlw b'11111111';15
   movwf 0x6F
   
   
   ;Procedo a controlar las variables del 0 al 15
   ; los registros 70 controlaran eso
   movlw .1
   movwf 0x71
   movlw .2
   movwf 0x72
   movlw .3
   movwf 0x73
   movlw .4
   movwf 0x74
   movlw .5
   movwf 0x75
   movlw .6
   movwf 0x77
   movlw .8
   movwf 0x78
   movlw .9
   movwf 0x79
   movlw .10
   movwf 0x7A
   movlw .11
   movwf 0x7B
   movlw .12
   movwf 0x7C
   movlw .13
   movwf 0x7D
   movlw .14
   movwf 0x7E
   movlw .15
   movwf 0x7F
   
capturarTeclado:
movlw b'11111110'
movwf 0x06 ; envio a portb
movlw b'11111101'
movwf 0x06 ; envio a portb
movlw b'11111011'
movwf 0x06 ; envio a portb
movlw b'11110111'
movwf 0x06 ; envio a portb
goto capturarTeclado   
    
    
display:
    ; procedo a desativar la interrupcion
    bcf 0x0B, 0
    goto pintarCERO
    
goto capturarTeclado
    
    
pintarCERO:
   movlw .9
   movwf 0x07
goto capturarTeclado

    
    
end

