
section .data
	;; outbuf [0] [1]   ... 
	outbuf db 0 , 10 	; reserving bytes for the output buffer. 
	
section .text
	global _start
_start:
	;; DIRECT , IN-FILE NUMERICAL INPUT 
	mov eax, 5		
	;; ADD 
	add al, 2		
	;; CONVERT NUM TO CHAR 
	add al , '0'		; add 48 to digit to convert it to ASCII char (7+48=55) 
	;; MOVE RESULT TO OUTPUT BUFFER
	mov byte [outbuf] , al	 ;  7 -> out[0]
				 ; \n -> out[1] 
	;; PRINT 
	mov eax, 4
	mov ebx, 1
	mov ecx, outbuf		; start with 7 ...
	mov edx, 2		; ... parse forth and finish with line feed 
	int 0x80		; Execute this. 
    ; Exit the program
	mov eax, 1      ; sys_exit system call number
	xor ebx, ebx    ; Exit status (0 for success)
	int 0x80        ; Call kernel 
