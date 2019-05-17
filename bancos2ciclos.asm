;Hacer un ciclo que llene 0x20 a 0x7f con nros consecutivos
; Luego de ello que llene 0xA0 a 0xA9
    
org 0x0
   
    
   ; se declara un posicion que guarde un contador
   ; dicho contador se guardara en 0xb0
   movlw 0xb0 ; aku es 0xb0
   movwf 0x04 ; fsr apunta a 0xb0
   ; el contador empezara en 1
   movlw .1
   movwf 0 ; ahora 0xb0 es .1
   ; fin de la declaracion del contador
   
   
   ; se declara un posicion que guardara en que parte del bank0 voy a guardar
   ; dicha posion sera 0xb1
   movlw 0xb1 ; aku es 0xb1
   movwf 0x04 ; fsr >> 0xb1
   ; ojo empiezo a poner los numeros consecutivos apartir de reg 0x20
   movlw 0x20 ; aku 
   movwf 0 ; 0xb1 es 0x20
   
   ; se declara una posicion que me indica hasta donde va a ir el bank 0
   ; dicha posicion sera 0xbe
   movlw 0xbe ; aku es 0xbe
   movwf 0x04 ; fsr apunta a 0xbe
   ; el limite del bank0 es 0x7f
   movlw 0x80 ; ojo por que el ciclo se hace 1 vez menos
   movwf 0 ; ahora 0xb6 es 0x7f
   ; fin de el limite 1
   
   ; se declara una posicion que me indica hasta donde va a ir el bank 1
   ; dicha posicion sera 0xbf
   movlw 0xbf
   movwf 0x04 ; aku apunta a 0xbf
   ; el limite del segundo banco es 0xa9
   movlw 0xaa ; ojo por que el ciclo se hace 1 vez menos
   movwf 0 ; ahora 0xbf es 0xa9
   ; fin del limite 2
   
   
   ; me cambio al banco 1 xq estan alli guardados los punteros
   bsf 0x03, 5 ; rp0
   bcf 0x03, 6 ; rp1
   
   
   ; se declara una rutina que llena de 0x20 a 0x7f 
   ; es llenado con lo que diga en 0xb0
   rellenarbank0:
   ; cargo al fsr lo que diga 0xb1
   movf 0xb1, 0 ; guardo en aku lo que diga 0xb1
   movwf 0x04 ; fsr sera lo que diga en 0xb1
   ; cargo al akumulador el contador
   movf 0xb0, 0
   ; guardo ese contador donde diga fsr
   movwf 0
   ; amenta en 1 el contador
   incf 0xb0, 1
   ; incrementa el puntero
   incf 0xb1, 1
   ; ojo: si 0x7f - puntero > 0 el ciclo continua
   ; cargo w con lo que hay en puntero
   movf 0xb1, 0
   ; resto el limite del banco0 con w si no es cero se repite
   ; status.z me controla si es cero
   subwf 0xbe, 0
   btfss 0x03, 2
   goto rellenarbank0
   
   ; en estos momentos el bank0 fue llenado.
   ; procedo llevando el puntero a 0xA0
   movlw 0xA0
   movwf 0xb1
   
   
   ; Se declara una rutina que llena desde 0xA0 hasta 0xA9
   rellenarbank1:
   ; cargo al fsr lo que diga 0xb1
   movf 0xb1, 0 ; guardo en aku lo que diga 0xb1
   movwf 0x04 ; fsr sera lo que diga en 0xb1
   ; cargo al akumulador el contador
   movf 0xb0, 0
   ; guardo ese contador donde diga fsr
   movwf 0
   ; amenta en 1 el contador
   incf 0xb0, 1
   ; incrementa el puntero
   incf 0xb1, 1
   ; ojo: si 0x7f - puntero > 0 el ciclo continua
   ; cargo w con lo que hay en puntero
   movf 0xb1, 0
   ; resto el limite del banco0 con w si no es cero se repite
   ; status.z me controla si es cero
   subwf 0xbf, 0
   btfss 0x03, 2
   goto rellenarbank1
   
   
     
    
   
   ; fin del programa
   fin:
   goto fin
   
    
    
end