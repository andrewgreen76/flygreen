	.section .text
	.global _start

_start:
	mov $1, %rax
	
	mov $60, %rax
	xor %rdi, %rdi
	syscall
