.intel_syntax		; directive : to run on min of i386
			; flat memory segmentation -  ~ $ nasm -f elf32 -o output.o input.asm 
.section .text 		; instructions 
start PROC
	mov eax, 213
	add eax, 432

	ret
start	endp		; endp
end 	start
