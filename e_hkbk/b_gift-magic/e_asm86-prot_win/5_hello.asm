
; _underscore is used to differentiate custom labels for the project
;; from the the similar , standard labels expected by the system ,
;; such as `main` and `printf`. 

	global _main		; _main is visible to the outside (in project development) 
	extern _printf		; _printf is visible to this program (from elsewhere in this project) 
	
	section .text		; meaning that instructions are below 
_main:				
	push message		
	call _printf
	add esp , 4
	ret

message:
	db 'Hello, world!', 10, 0
