
        global _start
        extern printf

        section .data
message:
        db 'Hello, world!', 10, 0

        section .text
_start:
        ; Call the main function
        call _main
        
        ; Exit the program
        mov eax, 1          ; sys_exit
        xor ebx, ebx        ; exit code 0
        int 0x80            ; invoke syscall

_main:
        ; Print the message
        push message		
        call printf
        add esp, 4

        ; Return to _start
        ret

	;; 
