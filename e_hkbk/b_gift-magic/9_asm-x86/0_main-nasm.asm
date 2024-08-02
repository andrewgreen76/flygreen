	;; SOME DEBUGGING WILL HAVE TO BE INVOLVED - GDB. 

	;; 	global start 				; Declare 'start' as a global symbol

section .text        ; Define the text (code) section
start:               ; Start of procedure 'start'
    mov eax, 213     ; Move 213 into eax
    add eax, 432     ; Add 432 to eax

    ret              ; Return from procedure 'start'
