
/*****************************************************
	PRE-LINKING VISIBILITY AND INCLUSION 
*****************************************************/

; _underscore is used to differentiate asm src labels from C tokens (such as `main` and `printf`).

	global _main 	; asm directive for OMNIVISIBILITY : _main is visible to the outside (in project development). 
	extern _printf 	; asm directive for INWARD INCLUSION : _printf is visible to this program (from elsewhere in this project). 
			; _printf is of the C library. 

/*****************************************************
	PUSHING DATA AS ARGS 
*****************************************************/

	section .text 	
_main: 
	push message	; Buffer location preserved as arg for upcoming call.
	call _printf	; Works on what's at SP.
	
	add esp , 4	; Upon return , SP is up by a word , removing buffer addr frame.
			;   Every addr takes up 1 word ; 1 word = 4 bytes in 32-bit systems. 
					
			; `add` is used instead of `pop` because "_printf is responsible for 
			;   popping its own arguments off the stack" , but SP has to be manually 
			;   adjusted in _main. POPPING IS IMPLICIT , SP ADJUSTMENT WILL HAVE TO BE EXPLICIT. 
					
	ret		; Exit.

message:
	db 'Hello, world!', 10, 0

;
