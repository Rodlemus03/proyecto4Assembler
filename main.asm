;Universidad del Valle de Guatemala
;Organización de computadoras y assembler
;Profesor Roger Diaz
;==================> Proyecto 4: par-impar <==================
;Integrantes:
;Mauricio Lemus 22461
;Nancy Mazariegos 22513
;Santiago Pereira 22318
;Mónica Salvatierra 22249

.386
.model flat, stdcall, c
.stack 4096 

.data
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; VARIABLES PARA REVISAR SI ES PAR O IMPAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


banderaRespuesta byte 0
banderaDado byte 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             CONTADORES                  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

contadorPosicionesJugador1 word 0
contadorPosicionesJugador2 word 0
contadorGeneral word 0
Dado byte 0
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                MENSAJES              ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

resp byte ? ;recibe la decision del usuario
msgD byte "Elige 1 para numero impar o 2 para numero par:", 0 ;mensaje para la decision del usuario
fmt1 db "%d",0
msgCorrecto byte "¡Respuesta correcta! Avanza a la siguiente casilla.", 0
msgIncorrecto byte "Respuesta incorrecta. Retrocede una casilla.", 0
msgGanador byte "¡Felicidades! Has llegado hasta el final.", 0
msgPerdedor byte "Has perdido. Retrocediste a la posición inicial y has elegido la respuesta incorrecta.", 0



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;             FORMATOS            ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

msg byte "Ingrese el nombre del usuario 1: ",0
msg1 byte "Ingrese el nombre del usuario 2: ",0
strBuff byte 255 DUP(?); Buffer para almacenar la cadena ingresada de maximo 255 caracteres
fmt dword "%s",0
msgN byte "Bienvenido al juego, deberan de indicar sus nombres primero:",0Ah,0





.code
includelib libucrt.lib
includelib legacy_stdio_definitions.lib
includelib libcmt.lib
includelib libvcruntime.lib

extrn printf:near
extrn scanf:near
extrn exit:near





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA INCREMENTAR POSICION J1 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IncrementarPosicionJ1 proc
    add contadorPosicionesJugador1, 1 ;Incrementa en uno el contador
    ret
IncrementarPosicionJ1 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA DECREMENTAR POSICION J1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DecrementarPosicionJ1 proc
    sub contadorPosicionesJugador1, 1 ;Decrementa en uno el contador
    ret
DecrementarPosicionJ1 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA INCREMENTAR POSICION J2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IncrementarPosicionJ2 proc
    add contadorPosicionesJugador2, 1;Incrementa en uno el contador
    ret
IncrementarPosicionJ2 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA DECREMENTAR POSICION J2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DecrementarPosicionJ2 proc
    sub contadorPosicionesJugador2, 1;Decrementa en uno el contador
    ret
DecrementarPosicionJ2 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA INCREMENTAR TURNO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IncrementarContador proc
    add contadorGeneral, 1 ;Incrementa en uno el contador
    ret
IncrementarContador endp


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA TIRAR LOS DADOS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TirarDados proc
    mov ax, 0    ; Limpia ax

    mov ax, dx   ; Mueve el valor a verificar en dx a ax
    xor dx, dx   ; Clear a dx para poder realizar la división

    mov cx, 6    ; Establece el divisor
    div cx       ; Realiza la división entre ax y cx

    add dl, 1    ; Suma 1 al resultado para obtener un número aleatorio entre 1 y 6

    mov al, dl   ; El número obtenido es almacenando en al

    and al, 0Fh  ; Operación lógica entre al y '0Fh', que básicamente solo toma en cuenta los 4 bits menos significativos, de manera que el número generado por el dado esté dentro del rango establecido (1-6)

    add al, '0'  ; Convierte el número generado en su representación en ASCII sumándole el valor de cero

    mov Dado, dl : Guarda el número generado en la variable Dado

    ret

TirarDados endp

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA COMPROBAR SI ES PAR O IMPAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;Descripción: Hace la verificación para comprobar si el número del dado es par o impar (Mónica)
esPar proc
    mov ax, dx       ; Mueve el número a verificar a ax
    xor dx, dx       ; Clear a dx para poder realizar la división
    mov cx, 2        ; Divide el valor por 2 para verificar si es par
    div cx           ; Realiza la división
    
    cmp dx, 0        ; Compara el residuo de la división con 0
    je Par           ; Si el residuo es 0, es par
    jmp Impar        ; Si el residuo no es 0, es impar
    
 Par:
    mov al, '2'      ; Si es par, se le asigna '2' a al
    ret
    
 Impar:
    mov al, '1'       ; Si es impar, se le asigna '1' a al
    ret
    
esPar endp

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA ELEGIR PAR O IMPAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
menuparimpar proc
    lea eax, msgD ; Carga la dirección de la cadena de mensaje en eax
    push eax ; Empuja la dirección en la pila
    call printf ; Llama a printf para mostrar el mensaje

    lea eax, resp   ; Carga la dirección de la variable num en eax
    push eax    ; Empuja la dirección en la pila
    lea eax, fmt1   ; Carga la dirección de la cadena de formato en eax
    push eax    ; Empuja la dirección en la pila
    call scanf  ; Llama a scanf para capturar el número ingresado

ret

menuparimpar endp  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA VERIFICAR NUMERO Y DECISION ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Descripción: Realiza una validación de la respuesta del usuario y el número del dado para ver si avanza o retrocede un espacio (Mónica)
verifdes proc
    mov al, resp            ;Mueve la respuesta del jugador a al
    mov bl, Dado            ;Mueve el número del dado a bl

    mov cl, banderaRespuesta  ; Mueve la bandera de respuesta a cl
    mov dl, banderaDado       ; Mueve la bandera del dado a dl

    cmp cl, dl             ; Compara la respuesta del usuario con el número en el dado
    je RespuestaCorrecta       ; Si el resultado coincide, salta a la etiqueta de 'RespuestaCorrecta'
    jmp RespuestaIncorrecta    ; Si el resultado no coincide, salta a la etiqueta de 'RespuestaIncorrecta'

RespuestaCorrecta:
    push offset msgCorrecto    
    call printf
    add esp, 4                 ; Clear al stack
    
    cmp contadorGeneral, 1     ; Verificar el contador general para ver de quién es el turno
    je AvanzarJ1
    jne AvanzarJ2
    
 RespuestaIncorrecta:
    push offset msgIncorrecto
    call printf
    add esp, 4                 ; Clear al stack
    
    cmp contadorGeneral, 1
    je RetrocederJ1
    jne RetrocederJ2
    
 AvanzarJ1:
    call IncrementarPosicionJ1
    
 RetrocederJ1:
    call DecrementarPosicionJ1
    
AvanzarJ2:
    call IncrementarPosicionJ2
    
 RetrocederJ2:
    call DecrementarPosicionJ2
    
 ; Verificar si se alcanzó la posición final (ganador)
    cmp contadorPosicion, 10      ; Compara el contador de posición con el valor de la posición final
    je Ganador                    ; Si son iguales, salta a la etiqueta de 'Ganador'

    ; Verificar si se retrocedió a la posición inicial (perdedor)
    cmp contadorPosicion, 0       ; Compara el contador de posición con el valor de la posición inicial
    je Perdedor                   ; Si son iguales, salta a la etiqueta de 'Perdedor'

    ret                          

Ganador:
    push offset msgGanador        ; Pone la dirección del mensaje '¡Felicidades! Has llegado al final del tablero.' en la pila
    call printf                   ; Imprime el mensaje
    add esp, 4                    ; Clear al stack
    ret                          

Perdedor:
    push offset msgPerdedor       ; Pone la dirección del mensaje 'Has retrocedido a la posición inicial. ¡Perdiste!' en la pila
    call printf                   ; Imprime el mensaje
    add esp, 4                    ; Clear al stack
    ret                          

ret
    
verifdes endp
    
main proc

;call menuparimpar
call TirarDados
call verifdes



call exit
main endp
    
end
