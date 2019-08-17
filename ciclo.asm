; Como un condicional
    
; procedo a crear un if
; El .33 va a contener un numero 0<=N<=255
; Si el numero en .33 es par se procede a poner FF en .32
; Si no es par .33 procedo a poner AA en .32
    
    
org 0x00
   
    ; Procedo a poner un numero en .33
    movlw .102
    movwf .33
    
    ;Procedo a verificar
    
    BTFSS .33, 0
    goto par
    goto impar
    
    ;si es par
    par:
    movlw 0xFF
    movwf .32
    
    ;Si es impar
    impar:
    movlw 0xAA
    movwf .32
    
end