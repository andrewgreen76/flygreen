	
section .bss
	
section .data
	dig_addr db 5		; Here 5 is treated a number , a representation of itself.
	outcount db 2		; Byte count for the output. 
	outstr db outcount     	; Need space for output string before it gets printed 
				; (the single digit + \0 = 2 bytes). 
	
section .text
	global _start    	
_start:
;;;;;;;;; CONV. NUM TO CHAR : ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	xor eax, eax 		; Need to prepare the eax register as a blank slate.
				; "xor eax, eax" is an optimized version of "mov eax, 0".
	mov al, dig_addr	; The byte for number 5 goes into eax.
	add al, '0'		; 5 + 48 = 53 -> acc ; This is how conversion from num.digit to char is done.
						     ; To convert char to num.digit , you'd subtract 48 from the register. 
		
;;;;;;;;; LOAD INTO RESERVED STRING BUFFER : ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov [str2disp] , al
;;;;;;;;; AND PRINT : ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov eax, 4             
	mov ebx, 1             
	mov ecx, str2disp
	mov edx, outcount
	int 0x80	
    ; Exit the program : 
	mov eax, 1       
	xor ebx, ebx     
	int 0x80         
