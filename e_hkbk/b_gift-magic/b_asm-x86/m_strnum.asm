	
section .bss
	
section .data
	dig_addr db "5" , 0 
	bytecount equ $ - dig_addr
	
section .text
	global _start    	
_start:				
	movzx eax, byte [dig_addr]	; xor eax, eax 	; optimized reg_clear
					; 'byte' extracts the LSB at dig_addr , holding a binval 0-255. 
					;; _ _ 1 1    0 1 0 1 
					;; This binval will be treated as an ASCII char representation.  
					; movzx zero-extends the value, clearing the higher bytes of eax  
	sub eax, '0' 			; char '0' has ASCII val 48 ;
					; If eax holds 
	
	mov eax, 4             
	mov ebx, 1             
	mov ecx, dig_addr
	mov edx, bytecount  
	int 0x80	
    ; Exit the program : 
	mov eax, 1       
	xor ebx, ebx     
	int 0x80         
