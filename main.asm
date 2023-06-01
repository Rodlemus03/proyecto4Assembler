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
contadorGeneral word 0
resp dd 0 ;recibe la decision del usuario
msgD byte "Elige 1 para numero impar o 2 para numero par:", 0 ;mensaje para la decision del usuario
fmt1 db "%d",0

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA COMPROBAR SI ES PAR O IMPAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
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
  
    call TirarDados
    call IncrementarContador
    call IncrementarContador
    call IncrementarContador
    call IncrementarContador
    call esPar proc
    main endp
    
   ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA ELEGIR PAR O IMPAR ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
menuparimpar proc
    lea eax, msgD
    push eax
    call printf

    lea eax, resp
    push eax
    lea eax, fmt1
    push eax
    call scanf

menuparimpar endp  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SUBRUTINA PARA VERIFICAR NUMERO Y DECISIÓN ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
verifdes proc
        
verifdes endp
    
    
    
end


