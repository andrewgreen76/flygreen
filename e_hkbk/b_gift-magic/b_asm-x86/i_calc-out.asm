
section .data
	;; outbuf [0] [1]   ... 
	out_addr db 0 , 10 	; reserving bytes for the output buffer. 
	
section .text
	global _start
_start:
	;; DIRECT , IN-FILE NUMERICAL INPUT 
	mov eax, 5		
	;; ADD ; result will be in the accumulator. 
	add eax, 2		
	;; CONVERT NUM.DIGIT TO CHAR 
	add eax , 48		; add 48 to convert 7 (bell) to ASCII code 55 ('7')
				;; more popular way : add al, '0' 
	;; MOVE RESULT TO OUTPUT BUFFER
	mov byte [out_addr] , al  ; "7" -> out[0]
				  ;  \n -> out[1] 
	;; PRINT 
	mov eax, 4
	mov ebx, 1
	mov ecx, out_addr	; start with 7 ...
	mov edx, 2		; ... parse forth and finish with line feed 
	int 0x80		; Call the kernel to execute. 
    ; Exit the program
	mov eax, 1      ; sys_exit system call number
	xor ebx, ebx    ; Exit status (0 for success)
	int 0x80        ; Call kernel 
