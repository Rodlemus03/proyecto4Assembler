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
    
    
    ;main
    public main
    main proc

    jmp inicio
    call TirarDados
  
    main endp
    
    
    
    
    
end


