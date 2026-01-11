	.section .data
dbuf:
	.ascii "Boo"         # the character to print

	.section .text
	.global _start

_start:
	mov $1, %rax       # syscall number for write
	mov $1, %rdi       # file descriptor 1 = stdout
	lea dbuf(%rip), %rsi  # address of the character
	# dbuf(% rip) - get addr/offset of the data buffer relative to rip
	# lea blah, % rsi - load rel.address into the source index register
	# rsi - where address of a smth like a string is to be stored
	mov $2, %rdx       # number of bytes to write
	syscall            # invoke kernel

	mov $60, %rax      # syscall number for exit
	xor %rdi, %rdi     # exit code 0
	syscall
