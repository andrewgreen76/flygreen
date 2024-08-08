
section .data
	;; outbuf 0   outbuf 1   ... 
	outbuf db 0 , 10 	; a method of reserving bytes for a string buffer. 


	
section .text
	global _start
_start:
	;; CONVERT NUM TO CHAR 
	xor eax, eax 		; clear entire acc. 
	mov al, 5		; 5 -> an acc byte
	add al, 2
	add al , '0'		; add 48 to digit to convert it to ASCII char (5+48=53) 
	;; MOVE TO OUTPUT BUFFER
	mov byte [outbuf] , al	 ;  5 -> out[0]
	;; PRINT 
	mov eax, 4
	mov ebx, 1
	mov ecx, outbuf
	mov edx, 2
	int 0x80
    ; Exit the program
	mov eax, 1      ; sys_exit system call number
	xor ebx, ebx    ; Exit status (0 for success)
	int 0x80        ; Call kernel 
