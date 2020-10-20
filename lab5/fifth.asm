; Лабораторна робота 5
; Виконав:   Главацьий О. С. ТМ-91 10.04.2020
; Команди пересилання. Варіант # 6
; Зміна другого та п'ятого символів рядка
; fifth.asm

.model small               
.stack 100h
.data
before db 'BEFORE:', 0dh,0ah, '$'
after db 'AFTER:', 0dh,0ah, '$'
line db 'ADROPOS $'
CR_LF db 0dh,0ah, '$'              
 
.code
start:
	mov ax, @data
	mov ds, ax
	
	mov ah, 9h
	mov dx, offset before
	int 21h
	
	mov ah, 40h  
	mov bx, 01h
	mov cx, 7h
	lea dx, line
	int 21h
	
	mov ah, 9h
	mov dx, offset CR_LF
	int 21h
	
	mov al, line + 1
	xchg line + 4, al
	xchg al, line + 1
	
	mov ah, 9h
	mov dx, offset after
	int 21h
	
	mov ah, 40h  
	mov bx, 01h
	mov cx, 7h
	lea dx, line
	int 21h
	
	mov ah, 9h
	mov dx, offset CR_LF
	int 21h
	
	mov ah, 4ch
	int 21h
	
end start
