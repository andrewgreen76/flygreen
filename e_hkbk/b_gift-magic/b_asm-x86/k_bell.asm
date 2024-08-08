	
section .bss
	
section .data
	bytcdbuf_addr db "Hello, world!" , 7 
	bytecount equ $ - bytcdbuf_addr
	
section .text
	global _start    	
_start:
	mov eax, 4             
	mov ebx, 1             
	mov ecx, bytcdbuf_addr
	mov edx, bytecount  
	int 0x80	
    ; Exit the program : 
	mov eax, 1       
	xor ebx, ebx     
	int 0x80         
