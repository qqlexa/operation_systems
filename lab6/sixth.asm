; Лабораторна робота 6
; Виконав Главацький О. С., гр. ТМ-91 Дата 22.04.2020
; Арифметичні команди. Варіант № 6
; Обчислення формули  z = (-2 * c - d + 53) / (a / 4 - 1)

;				
;				
;				a = 8
;				c = 5
;				d = 33
; 				z = 10
;
;


.model small
.stack 100h

.data      
	a dw 8      
	c dw 5
	d dw 33
	
	message db 'Error! Division by zero.$'
	
	z dw ? 
	
	up dw ?
	down dw ?



.code
begin:
	; z = (-2 * c - d + 53) / (a / 4 - 1)
	
	mov ax, @data
	mov ds, ax
	           
	; down = a / 4
	mov down, 4
	mov ax, a
	cwd
	idiv down
	
	; if a / 4  == 1 then down == 
	cmp ax, 1                     
	je @error
	
	; down = (a / 4 - 1)
	dec ax   				; down--
	mov down, ax			
	
	; up = -2 * c
	mov ax, c
	mov up, -2
	imul up           		 ; ax *= up
	
	; up = -2 * c - d
	mov bx, d
	sbb ax, bx
	
	
	; up = -2 * c - d + 53
	adc ax, 53

	; z = up / down
	cwd
	idiv down
	mov z, ax
	
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