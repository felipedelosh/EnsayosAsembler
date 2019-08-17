; Confugurar cualquier patica de puerto A como entrada digital
; Hacer prender y apagar 16 led como manguera de navidad
    
org 0x0
   
    ; Configurar El Puerto A 
    ; Procedo A mandarle un 7 a el ADCON1
    movlw 0x9f ; voy a apuntar a adcon1
    movwf 0x04 ; fsr apunta a adcon
    movlw .7 ; aku es .7
    movwf 0x0 ; ADCON1 es .7
    
    ; Acabo de decirle a adcon1 que las entradas son digitales
    ; voy a decirle a trisA que la entrada 0 es entrada
    movlw 0x85 ; voy a apuntar a trisA
    movwf 0x04 ; apunta fsr a tris a
    movlw b'1'
    movwf 0x0 ; trisa tiene puerto 0 de entrada
    
    ; Configurar los trisB y trisC como salidas
    movlw 0x86 ; 
    movwf 0x04 ; fsr > trisB
    movlw .0 ; 0
    movwf 0x0 ; trisB salida
    
    movlw 0x87
    movwf 0x04 ; fsr > TrisC
    movlw .0 ; 0
    movwf 0x0 ; trisC salida
    
    
    rutina:
    
    ; Comparo en que esta portA, 0
    bsf 0x05, 0
    goto iraA
    goto iraB
    
    
    iraA:
    ; Apago todos los del puerto C
    movlw .0
    movwf 0x07
    
	; Procedo a usar 0x21 para los corriemientos
	movlw .1
	movwf 0x21
	; Utilizo corrimiento con un cicli que se hace 7 veces
	movlw .8
	movwf .32
	cicloA:
	; Procedo a mover de 0x21 a portB
	movf 0x21, 0
	movwf 0x06
	; procedo a correr a la  der
	rlf 0x21, 1
	; Procedo a limpiar el carry status.bit0
	bcf 0x03, 0
	DECFSZ .32, 1
	goto cicloA
    goto finrutina
    
    iraB:
    ; Apago los del puerto B
    movlw .0
    movwf 0x06
    ; Prendo los del puerto C
    movlw .255
    movwf 0x07
    goto finrutina
    
    finrutina:
    goto rutina
    
end

