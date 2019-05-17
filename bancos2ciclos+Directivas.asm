;Hacer un ciclo que llene 0x20 a 0x7f con nros consecutivos
; Luego de ello que llene 0xA0 a 0xA9
org 0x0
    
#include p16f877a.inc ; se llama la libreria para trabajar con directivas
    
variable puntero=0x20 ; se declara un puntero que dira donde se debe de 
    ; guardar el contador
variable contador=0x1 ; se declara un contador

while puntero <= 0x7f
    
    ; procedo a actualizar fsr con lo que diga puntero
    movlw puntero
    movwf 0x04 ; actualizo fsr
    ; guardo el contador a donde apunter fsr
    movlw contador
    movwf 0
    
    ; el dato se guardo por ello el contador aumenta
    contador = contador + 1
    ; el dato se guardo por ello el puntero aumenta
    puntero = puntero + 1
endw  ; fin del ciclo que llena el primer banco de memoria
    
    
; se actualiza el puntero para que llene el segundo banco de memoria
puntero = 0xa0
    
while puntero <= 0xA9
     ; procedo a actualizar fsr con lo que diga puntero
    movlw puntero
    movwf 0x04 ; actualizo fsr
    ; guardo el contador a donde apunter fsr
    movlw contador
    movwf 0
    
    ; el dato se guardo por ello el contador aumenta
    contador = contador + 1
    ; el dato se guardo por ello el puntero aumenta
    puntero = puntero + 1

endw; fin del puntero que llena el segundo banco de memoria
    
    
; fin del programa
    
fin:
goto fin
    
end