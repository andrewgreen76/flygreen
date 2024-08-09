	
section .bss
	
section .data
strbuf_addr db "Hello, " , 11 , "world!" , 0  	; Let's do something different here. 
	
section .text	
global _start
	
_start:
	mov eax, 4             
	mov ebx, 1             
	mov ecx, strbuf_addr   
	mov edx, 15 		;; Do you really want to change the byte count manually
				;; every time you make a change to the sequence of bytes ? 
	int 0x80	
    ; Exit the program : 
	mov eax, 1       
	xor ebx, ebx     
	int 0x80         
