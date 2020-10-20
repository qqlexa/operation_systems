; 4labC.asm

	.model	tiny
	.code
	org	100h
main:	
	mov	ah, 9h
	mov	dx,offset message 
	int	21h	
	ret	
message db	"Hello World!",0Dh,0Ah,'$'
	end	main