	;; 
	
section .data
    number db "645", 0xA   ; number as string + line feed 
	
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
section .text
    global _start         ; Entry point for linking
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
_start:
    ; Prepare for sys_write
    mov eax, 4            ; sys_write system call number
    mov ebx, 1            ; File descriptor (stdout)
    mov ecx, number       ; Buffer containing the string
    mov edx, 4            ; Length of the string to write (including newline)

    ; Execute sys_write
    int 0x80              ; Call kernel

    ; Exit the program
    mov eax, 1            ; sys_exit system call number
    xor ebx, ebx          ; Exit status (0 for success)
    int 0x80              ; Call kernel
