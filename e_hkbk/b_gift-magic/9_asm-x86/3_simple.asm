section .data
    ; Define constants or variables here (if needed)

section .text
    global _start   ; Entry point for the program

_start:
    ; Initialize variables
    mov eax, 213    ; Load first number into EAX
    add eax, 432    ; Add second number to EAX

    ; Optionally, store the result in a variable or register

    ; Exit the program
    mov eax, 1      ; sys_exit syscall number
    xor ebx, ebx    ; Exit code 0
    int 0x80        ; Call kernel


	;; While using section .text is valid and necessary in larger programs 
	;; with multiple code sections (such as when defining functions or data
	;; segments separately), for small standalone programs, placing instructions
	;; directly under _start is commonly practiced for its simplicity and clarity.
