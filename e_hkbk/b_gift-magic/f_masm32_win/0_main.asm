	.386			; for 32-bit systems / protected mode. 

	.model flat		; Flat memory segmentation model : memory is accessible/addressable 
				; in the form of one line from low to high with reference pointers
				; and offsets instead of referencing individual process segments
				; (CS, DS, etc.).

	.code			; Code segment : instructions start below. 
				; "start" is the name for the entry procedure , 
start PROC			; "PROC" is the directive for the start of a procedure/subroutine. 
	mov eax, 213
	add eax, 432
	ret
start ENDP
	end start

	;; 
