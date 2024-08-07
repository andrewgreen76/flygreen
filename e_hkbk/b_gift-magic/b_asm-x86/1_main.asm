
section .data
	integer_str db '12345', 0  ; Example integer string with null terminator
	

section .text
	global _start 
_start:
	mov eax, 4        ; sys_write syscall number
	mov ebx, 1        ; File descriptor (stdout)
	mov ecx, integer_str  ; Address of the integer string
	mov edx, 5        ; Length of the integer string (excluding null terminator)
	int 0x80          ; Call kernel

    ; Exit the program
	mov eax, 1        ; sys_exit syscall number
	xor ebx, ebx      ; Exit status (0 for success)
	int 0x80          ; Call kernel
