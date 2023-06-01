;Universidad del Valle de Guatemala
;Organización de computadoras y assembler
;Profesor Roger Diaz
;==================> Proyecto 4: par-impar <==================
;Integrantes:
;Mauricio Lemus 22461
;Nancy Mazariegos 22513
;Santiago Pereira 22318
;Monica Salvatierra 22249

.386
.model flat, stdcall, c
.stack 4096

.data
contadorPosicionesJugador1 word 0
contadorPosicionesJugador2 word 0

contadorGeneral word 0


Dado byte 0
;Variables etiqueta
msg byte "Ingrese el nombre del usuario 1: ",0
strBuff byte 255 DUP(?); Buffer para almacenar la cadena ingresada de maximo 255 caracteres
fmt dword "%s",0


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
    add contadorPosicionesJugador1, 1
    ret
IncrementarPosicionJ1 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA DECREMENTAR POSICION J1;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DecrementarPosicionJ1 proc
    sub contadorPosicionesJugador1, 1
    ret
DecrementarPosicionJ1 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA INCREMENTAR POSICION J2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IncrementarPosicionJ2 proc
    add contadorPosicionesJugador2, 1
    ret
IncrementarPosicionJ2 endp
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA DECREMENTAR POSICION J2;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
DecrementarPosicionJ2 proc
    sub contadorPosicionesJugador2, 1
    ret
DecrementarPosicionJ2 endp

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA INCREMENTAR TURNO ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
IncrementarContador proc
    add contadorGeneral, 1
    ret
IncrementarContador endp



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA TIRAR LOS DADOS ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
TirarDados proc
    mov ax, 0

    mov ax, dx
    xor dx, dx

    mov cx, 6
    div cx

    add dl, 1

    mov al, dl

    and al, 0Fh

    add al, '0'

    mov Dado, dl

    ret

TirarDados endp

inicio:
    push ebp
    mov ebp, esp

    push offset msg 		; Imprimir mensaje
    call printf

    lea  eax, strBuff 		; Obtener dirección del buffer
    push eax 				; Empujar dirección a la pila
    push offset fmt 		; Empujar formato a la pila
    call scanf 				; Leer cadena desde la entrada estándar

   

    add esp, 8 				; Limpiar la pila

    mov esp, ebp
    pop ebp
    ret
    
    
    ;main
    public main
    main proc

    ;jmp inicio
  

    ;Tirar dado generando random
    call TirarDados

    ;Prueba llamar a las funciones de incremento
    call IncrementarContador
    call IncrementarContador
    call IncrementarContador
    call IncrementarContador

    ;Prueba llamar a los incrementos y decrementos del contador de posicion de jugador 1
    call IncrementarPosicionJ1
    call IncrementarPosicionJ1
    call IncrementarPosicionJ1
    call IncrementarPosicionJ1
    call DecrementarPosicionJ1


    ;Prueba llamar a los incrementos y decrementos del contador de posicion de jugador 2
    call IncrementarPosicionJ2
    call IncrementarPosicionJ2
    call IncrementarPosicionJ2
    call IncrementarPosicionJ2
    call DecrementarPosicionJ2

    main endp
    
    
    
    
    
end


