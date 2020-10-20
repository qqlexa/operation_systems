; 4labE.asm
text	segment			
assume 	CS:text, DS:data	
					
begin:	mov	AX, data		
	mov	DS, AX		
	mov	AH, 09h		
	mov	DX, offset mesg
	int 	21h			
	mov	AH, 4Ch		
	mov Al, 0			
	int		21h			
text	ends				

data	segment			
mesg	db "Hello Word!", 0Dh, 0Ah, '$'
data	ends				

stk	segment stack		
	db 256 dup (0)		
stk	ends				
	end begin			
