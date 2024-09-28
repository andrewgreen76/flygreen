
	ORG 0x7c00 		; offset in QEMU machine's RAM , where NASM will look 
	BITS 16			; for 16-bit CPU architecture

				; No need to announce the start of the code section. 
start:
	mov ah , 0eh
	mov al , 'A'
	int 0x10		; strictly a BIOS interrupt , a BIOS ISR , independent of the OS 

	times 510-($-$$) db 0	; quantity of zeroes to populate throughout the 510-byte chunk 
				; $ - current location in code
				; $$ - start location of code (ORiGin?)
				; Logic behind the math : 
				;  . Looks like we are computing the remainder of a (boot?) sector.
				;  . Looks like we are writing bootstrap code (FSBL).
				; $-$$ - current size of code
				; 510-($-$$) : 0x7c00 + ($-$$) - (rem_of_510 w/ 0's) , and that's before the bootsig.
				;
				; 0--- | 0x7c00 + ($-$$) + rem_510_zeropad | 0xAA | 0x55 |
	dw 0xAA55
