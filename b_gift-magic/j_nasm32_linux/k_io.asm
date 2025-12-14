
section .data
numlen equ 5
	
section .bss
usernum resb numlen
	
section .data
ps_addr db "Enter a digit: " , 0 
pslen_addr equ $ - ps_addr
out_addr db "You entered: " , 0		; You don't have to inject a line feed ; hitting ENTER upon input will do the trick. 
outlen_addr equ $ - out_addr
	
section .text
	global _start    	
_start:
	;; PRINT THE PROMPT STRING 
	mov eax, 4             
	mov ebx, 1             
	mov ecx, ps_addr
	mov edx, pslen_addr  
	int 0x80
	;; ACCEPT THE NUMBER 
	mov eax, 3		; sys_read 
	mov ebx, 0		; interface stream - stdin (src)  
	mov ecx, usernum	; pointed buffer   - num (dest)
	mov edx, 5
	int 0x80
	;; ENTER (with automatic line feed) , OUTPUT MESSAGE
	mov eax, 4             
	mov ebx, 1             
	mov ecx, out_addr
	mov edx, outlen_addr  
	int 0x80	
	;; PRINT OUTPUT
	mov eax, 4
	mov ebx, 1
	mov ecx, usernum
	mov edx, 5
	int 0x80
	
    ; Exit the program : 
	mov eax, 1       
	xor ebx, ebx     
	int 0x80         
