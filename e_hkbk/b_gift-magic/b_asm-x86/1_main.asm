	
section .bss
	
section .data
    strbuf db "Hello, world!", 0   ; Let's try something different.  
	
section .text
    global _start         
_start:
    mov eax, 4            
    mov ebx, 1             
    mov ecx, strbuf        
    mov edx, 14             ; In this piece of code you may have to change
			    ; the character count with every change in the string. 
	;; Helloworld, ! + \0 = 14
	;; 
    int 0x80              
	
    ; Exit the program
    mov eax, 1            
    xor ebx, ebx          
    int 0x80              
