	
section .bss
	
section .data
strbuf_addr db "Hello, " , 11 , "world!" , 0
; [str_length] = [current buffer-byte count within data segment] - [address of string] : 
bytecount equ $ - strbuf_addr 	; equ (=) statements do support internal arithmetic expressions (+, -, *, /) 
	
section .text
global _start    	
_start:
	mov eax, 4             
	mov ebx, 1             
	mov ecx, strbuf_addr   
	mov edx, bytecount	;; That's better.  
	int 0x80	
    ; Exit the program : 
	mov eax, 1       
	xor ebx, ebx     
	int 0x80         
