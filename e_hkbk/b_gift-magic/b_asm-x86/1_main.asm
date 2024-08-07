	
section .bss
	
section .data
	strbuf_addr db 0 
	bytecount equ $ - strbuf_addr   
	
section .text
	global _start    	
_start:
	mov eax, 0
	mov ebx, 0             
	mov ecx, 0   
	mov edx, 0  
	int 0x80	
    ; Exit the program : 
	mov eax, 1       
	xor ebx, ebx     
	int 0x80         
