; Лабораторна робота 7
; Виконав Главацький О. С., гр. ТМ-91 Дата 22.04.2020
; Організація умовних переходів. Варіант № 6
; if a > b { a / b - 1 }
; else if a == b { -25 }
; else (a < b) {(b^3 - 5) / a }
; 
.model small
.stack 100h
.data
	a dw 6
	b dw 2
	
	message db 'Error! Division by zero.$'
	
	k dw ?
	x dw ?

.code 
begin:
	mov ax, @data
	mov ds, ax
	
	mov ax, a
	cmp ax, b
	je @equal
	jg @more
	jl @less

@more:
	
	; a / b
	mov ax, a
	
	mov bx, b
	cmp bx, 0                     
	je @error
	
	cwd
	idiv bx
	
	; a / b - 1
	dec ax
	
	jmp @main

@equal:
	; -25
	mov ax, -25
	jmp @main
	

@less:
	; b^3
	mov ax, b
	cwd
	imul b
	imul b
	
	; b^3 - 5
	sbb ax, 5
	cwd
	
	cmp ax, a                     
	je @error
	
	idiv a
	
	
@main:
	mov x, ax
	push ax
	
	cmp ax, 0
	jns @def_count    
	
	mov ah, 02h 
	mov dl, '-'
	int 21h
	
	pop ax
	neg ax

@def_count:	
	xor cx, cx
	mov bx, 10
	
@dvsn:	
	xor dx, dx
	div bx
	push dx
	inc cx
	test ax, ax
	jnz short @dvsn
	mov ah, 02h

@output: 
	pop dx
	add dl, 30h
	int 21h
	loop @output
	jmp @end

@error:	
	mov ah, 09h
	mov dx, offset message
	int 21h
	
@end:	
	mov ah, 4ch
	int 21h
	
end begin