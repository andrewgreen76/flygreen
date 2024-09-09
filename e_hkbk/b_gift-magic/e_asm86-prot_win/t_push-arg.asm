
/***************************************************************************************************************
(3) reason for pushing data is to HAVE IT WORKED ON BY A CALLEE FUNCTION. 
***************************************************************************************************************/
	
	global _main 	 
	extern _printf

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	section .text 	
_main: 
	push message	; Pushing arg for upcoming call.
	call _printf	; Subroutine working on the pushed arg.
			; Upon return the 'message' is popped off implicitly.  
	
	add esp , 4	; SP has to be manually adjusted - by the size of the popped-off data/addr.  
					
	ret		

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

message:
	db 'Hello, world!', 10, 0

;
