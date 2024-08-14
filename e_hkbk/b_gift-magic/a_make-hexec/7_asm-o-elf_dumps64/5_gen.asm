section .data
bufaddr db "Hava Nagila" , 10
buflen equ $ - bufaddr
	
section .text
	global _start
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, bufaddr
	mov edx, buflen
	int 0x80
	
	mov eax, 1
	int 0x80
