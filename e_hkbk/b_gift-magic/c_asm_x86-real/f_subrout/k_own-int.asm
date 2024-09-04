
;############################################################
	;; THIS CODE IS FOR REAL-MODE ASSEMBLY ONLY !
;############################################################

	org 100h
	
	push ds
	;;;;;;;;;;;;;;;;;;;;;;;

	mov ax, 0
	mov ds, ax
	mov [0x04] , handle_int0
	mov [0x06] , cs

	int 0x01

	;;;;;;;;;;;;;;;;;;;;;;;
	pop ds

	ret
           
;############################################################

; This is just simple of way of isolating a routine from
; the program's main flow - by placing the routine after
; the final `ret`, or after the main code.
 
handle_int0:
	mov ah , 0eh
	mov al , 'A'
	int 0x10      ; out interrupt will depend on another interrupt
	iret          ; return from int	
