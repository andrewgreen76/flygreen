include \SrcALL\V1_Header.asm

	
	call ScreenInit
	
	
	
	
	;jmp TestFlagOperations
	;jmp TestLogicalOps
	;jmp TestShiftingLeft	;Test Left Bit shifts 
	jmp TestShiftingRight	;Test Right Bitshifts
	
	jmp $

TestShiftingValues:
	mov ax,0
	sahf	
	mov cx,4			;Loop Count
	
	mov ax,04C0Eh
	or ax,ax
	ret
TestShiftingLeft:	
	call TestShiftingValues
TestShiftingAgain1:	
	call DoMonitorAXBitsFlags
	rol ax,1		;ROtate Left - note N must be 1 on 8086
	loop TestShiftingAgain1
	
	call NewLine
	
	call TestShiftingValues
TestShiftingAgain2:	
	call DoMonitorAXBitsFlags
	rcl ax,1		;Rotate with Carry Left - note N must be 1 on 8086
	loop TestShiftingAgain2
	
	call NewLine
	
	call TestShiftingValues
TestShiftingAgain3:	
	call DoMonitorAXBitsFlags
	shl ax,1		;SHift logical Left - note N must be 1 on 8086
	loop TestShiftingAgain3
	
	call NewLine
	
	call TestShiftingValues
TestShiftingAgain4:	;SAL and SHL do the same thing!!!!
	call DoMonitorAXBitsFlags
	sal ax,1		;Shift Arithmatic left - note N must be 1 on 8086 
	loop TestShiftingAgain4

	call NewLine
	
	call TestShiftingValues
	mov ax,08C0Eh
	or ax,ax
TestShiftingAgain4b:	;SAL and SHL do the same thing!!!!
	call DoMonitorAXBitsFlags
	sal ax,1			;Shift Arithmatic left - note N must be 1 on 8086 
	loop TestShiftingAgain4b
	
	jmp $
	
	
TestShiftingRight:	
	call TestShiftingValues
TestShiftingAgain5:	
	call DoMonitorAXBitsFlags
	ror ax,1		;ROtate Right - note N must be 1 on 8086
	loop TestShiftingAgain5
	
	call NewLine
	
	call TestShiftingValues
TestShiftingAgain6:	
	call DoMonitorAXBitsFlags
	rcr ax,1		;Rotate with Carry Right - note N must be 1 on 8086
	loop TestShiftingAgain6
	
	call NewLine
	
	call TestShiftingValues
TestShiftingAgain7:	
	call DoMonitorAXBitsFlags
	shr ax,1		;SHift logical Right - note N must be 1 on 8086
	loop TestShiftingAgain7
	
	call NewLine
	
	call TestShiftingValues
TestShiftingAgain8:	;SAR drags top bit right 
	call DoMonitorAXBitsFlags
	sar ax,1		;Shift Arithmatic Right - note N must be 1 on 8086 
	loop TestShiftingAgain8
	
	call NewLine
	
	call TestShiftingValues
	mov ax,08C0Eh
	or ax,ax
TestShiftingAgain8b:;SAR drags top bit right 
	call DoMonitorAXBitsFlags
	sar ax,1		;Shift Arithmatic Right - note N must be 1 on 8086 
	loop TestShiftingAgain8b
	jmp $
	
	
	
	
	
	
	
TestFlagOperations:
	mov ax,0FFFFh
	sahf					;Set Flags
;The Carry Flag	
	clc						;Clear Carry Flag (C)
	call DoMonitorAXBitsFlags
	stc						;Set Carry Flag (C)
	call DoMonitorAXBitsFlags
	
	cmc						;Complement Carry Flag (invert) (C)
	call DoMonitorAXBitsFlags
	cmc						;Complement Carry Flag (invert) (C)
	call DoMonitorAXBitsFlags

	call NewLine
	
;The Interrupt Flag - Clearing I disables Maskable Hardware Interrupts
	cli						;Clear the Interrupt flag (I)
	call DoMonitorAXBitsFlags
	sti						;Set the Interrupt flag (I)
	call DoMonitorAXBitsFlags
	
	call NewLine
	
;The Direction Flag
	std						;Set the Direction flag (D)
	call DoMonitorAXBitsFlags
	cld						;Clear the Direction flag (D)
	call DoMonitorAXBitsFlags

	
	jmp $

	
	
TestLogicalOps:
	mov bx,00000h
	mov ax,01234h				;Test starting value
	call DoMonitorAXBitsBX
	
	
	mov bx,0ff10h
	and ax,bx				;AND mask (Keep bits set to 1 / set bits to 0)
	call DoMonitorAXBitsBX
	
	mov bx,7081h
	or ax,bx				;OR mask  (Leave 0 bits unchanged / Set bits to 1)
	call DoMonitorAXBitsBX
	
	mov bx,0FF3h
	xor ax,bx				;XOR mask  (Invert bits set to 1)
	call DoMonitorAXBitsBX
	
	mov bx,00000h
	not ax					;Flip bits of AX
	call DoMonitorAXBitsBX
	
	mov bx,00000h
	neg ax					;Flip bits of AX
	call DoMonitorAXBitsBX
	
	call NewLine
	mov ax,000FFh			;Test starting value
	sahf 					;Zero flags
	pushf
	push ax
		call DoMonitorAXBitsFlags	
		and ax,00F00h		;AND Command sets flags accordingly
		call DoMonitorAXBitsFlags
		
		call NewLine
	pop ax
	popf
	call DoMonitorAXBitsFlags
	test ax,00F00h			;TEST sets flags like AND, but leaves AX unchanged
	call DoMonitorAXBitsFlags

	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	mov ax,1111001101100000b
	call DoMonitorBits
	
	call NewLine
	lahf
	CLI
	call DoMonitorAXBitsFlags
	STI
	call DoMonitorAXBitsFlags
	
	cmc
	STD
	call DoMonitorAXBitsFlags
	CLD
	call DoMonitorAXBitsFlags
	call NewLine
	
	Mov ax,1234h		;Load AX with some junk
	call DoMonitorAX	;Because top bit was 1, all bits of AH will be 1
	Mov al,01111111b	;Load the bottom half with a value
	call DoMonitorAX
	
	cbw					;Expand AL->AX (convert byte to word)
	call DoMonitorAX	;Because top bit was 0, all bits of AH will be 0
	
	call NewLine
	
	
	Mov ax,1234h		;Load AX with some junk
	call DoMonitorAX	;Because top bit was 1, all bits of AH will be 1
	Mov al,10000000b	;Load the bottom half with a value	
	call DoMonitorAX
	
	cbw					;Expand AL->AX	 
	call DoMonitorAX	;Because top bit was 1, all bits of AH will be 1
	
	call NewLine
	
	jmp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
DoMonitorBits:
	push ax
		push bx
		push cx
			mov bx,ax
			call DoMonitorBitsPart
			mov al,' '
			call printchar 
			call DoMonitorBitsPart
		pop cx
		pop bx
	pop ax
	ret
DoMonitorBitsPart:
	mov cx,8	
DoMonitorBitsPartAgain:
	rol bx,1
	mov al,'0'
	jnc DoMonitorBit0	;C=Carry
	mov al,'1'
DoMonitorBit0:
	
	call printchar 
	loop DoMonitorBitsPartAgain
	ret
DoMonitorFlags:
	push ax	
		pushf
			mov ah,'-'
			mov al,ah
			jnc DoMonitorFlagsNC	;C=Carry
			mov al,'C'
DoMonitorFlagsNC:
			call printchar 
		popf
		pushf
			mov al,ah
			jnp DoMonitorFlagsNP	;P=parity (P=even)
			mov al,'P'
DoMonitorFlagsNP:
			call printchar 
		popf
		pushf
			mov al,ah
			jnz DoMonitorFlagsNZ	;Z=zero
			mov al,'Z'
DoMonitorFlagsNZ:
			call printchar 
		popf
		pushf
			mov al,ah
			jns DoMonitorFlagsNS	;Sign (S=negative)
			mov al,'S'
DoMonitorFlagsNS:
			call printchar 
		popf
		pushf
			mov al,ah
			jno DoMonitorFlagsNO	;Overflow(0=Sign flipped)
			mov al,'O'
DoMonitorFlagsNO:
			call printchar 
		popf
		pushf
		pop ax
		push ax	;  FEDCBA9876543210
			and ax,0000001000000000b
			mov al,'-'
			jz DoMonitorFlagsNI	;Overflow(0=Sign flipped)
			mov al,'I'
DoMonitorFlagsNI:
			call printchar 
		popf
		pushf
		pop ax
		push ax	;  FEDCBA9876543210
			and ax,0000010000000000b
			mov al,'-'
			jz DoMonitorFlagsND	;Overflow(0=Sign flipped)
			mov al,'D'
DoMonitorFlagsND:
			call printchar 
		popf
		
		pushf	
			mov al,' '
			call printchar 
		popf
	pop ax
	ret

	
DoMonitorAXBitsFlags:				;Show AX+BX To the screen	
	push ax
		pushf
			call DoMonitorAX
			call DoMonitorBits
			mov al,' '
			call printchar 
		popf
		pushf
			call DoMonitorFlags
			call NewLine	
		popf
	pop ax
	ret

DoMonitorAXBitsBX:				;Show AX+BX To the screen	
	push ax
	push bx
		pushf
			call DoMonitorAX
			call DoMonitorBits
			mov al,' '
			call printchar 
			call DoMonitorBX
			call NewLine
		popf
	pop bx
	pop ax
	ret
	
DoMonitorAX:				;Show AX To the screen
	push bx
	push ax
		mov bx,ax
		mov al,'A'
DoMonitorNX:
		call DoMonitorOneX	;Function in the Monitor - shows [AL]X:BX
	pop ax
	pop bx
	ret
	
DoMonitorBX:				;Show AX To the screen
	push bx
	push ax
		mov al,'B'
		jmp DoMonitorNX

include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

include \SrcALL\V1_Footer.asm

