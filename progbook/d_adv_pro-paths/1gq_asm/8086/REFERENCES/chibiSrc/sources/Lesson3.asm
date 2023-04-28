include \SrcALL\V1_Header.asm

	call ScreenInit
	
	;jmp TestConditionsEqualNE		;Zero Flag test
	;jmp TestConditionsCMPunsigned	;CMP Tests unsigned
	;jmp TestConditionsCMPsigned	;CMP tests signed
	
	
	;jmp TestConditionsSign
	
	;jmp TestConditionsParity
	jmp TestConditionsOverflow
	
	
	jmp TestLoop1	;Test A Loop with CX
	jmp TestLoop2	;Test A Loop with LOOPZ/NZ
	
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
;Lets test Loop and JCXZ

;Loop will repeat until CX=0 - so we can use CX as a loop counter...

;BUT... what if CX was zero at the start? our loop would go on for 65536 iterations!
;well, we can use JCXZ
	
TestLoop1:		
	mov cx,5			;Loop count
	;mov cx,0			;Try setting CX=0!
	mov ax,10
LoopAgain:
	jcxz LoopDone		;Jump if CX is zero (it isn't)
	
	dec ax				;Decrease test value
	
	call DoMontiorCXAXFlags	;Show details
	
	loop LoopAgain		;dec CX and loop until CX=0
	
LoopDone:	
	call newline
	call DoMontiorCXAXFlags	;Show details
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

;Lets try another type of Loop... using LOOPNZ/Z

;These loops will end when one of two conditions occur..
;1. CX reaches zero
;2. 	For LOOPZ when Z flag is zero (set by previous command)
;2. 	For LOOPNZ when Z flag is zero (set by previous command)

TestLoop2:
	mov cx,10			;Maximum loop
	;mov cx,5			;Try a smaller value!
	mov ax,8
LoopAgain2:
	
	dec ax				;Set zero flag?
	
	call DoMontiorCXAXFlags	;Show details
	
	loopnz LoopAgain2	;dec CX and loop if NZ or CX=0
	;loopz LoopAgain	;dec CX and loop if Z or CX=0
LoopDone2:	
	call newline
	call DoMontiorCXAXFlags	;Show details
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
TestConditionsEqualNE:	
	mov ax,1
	
	;cmp ax,1		;AX=1 so difference=0 (Z)
	;cmp ax,2		;AX=1 so difference!=0 (NZ)
	dec ax			;AX was 1 - now 0 so Z=1
	;inc ax			;AX was 1 - now 2 so Z=0
	
	;mov ax,0FFFFh	;if a register overflows back to zero, Z will also be set
	;inc ax
	
	call DoMonitorFlagsNL
	
	jz JumpZero 	;Jump if AX = cmp value (JE)
	jnz JumpNonZero ;Jump if AX = cmp value (JNE)
	jmp NoJump

JumpNonZero:
	mov al,'N'
	call printchar 
JumpZero:	
	mov al,'Z'
	call printchar 
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

TestConditionsSign:	
	mov ax,0
	
	;dec ax			;AX now negative 
	inc ax			;AX positive
	
	call DoMonitorFlagsNL
	
	js JumpSigned 	;Jump if AX = cmp value (JE)
	jns JumpNotSigned ;Jump if AX = cmp value (JNE)
	jmp NoJump

JumpNotSigned:
	mov al,'N'
	call printchar 
JumpSigned:	
	mov al,'S'
	call printchar 
	jmp $
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestConditionsOverflow:	;Overflow test

	mov ax,32760
	
	add ax,32		;This will cause an overlow
	;add ax,2		;This will not cause an overlow

	call DoMonitorFlagsNL
	
	jo JumpOverflow 	;Jump if overflow (sign flipped)
	jno JumpNoOverflow 	;Jump if overflow (sign flipped)
	jmp NoJump


JumpNoOverflow:	
	mov al,'N'
	call printchar 
JumpOverflow:	
	mov al,'O'
	call printchar 
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestConditionsParity:	
	;Parity test
		;  FEDCBA9876543210
	mov ax,0000000000010000b
	inc ax				;00010001b
	;inc ax				;00010010b
	;inc ax				;00010011b
	;inc ax				;00010100b
	
	call DoMonitorFlagsNL
	
	jpo JumpParityOdd	;P=0 (Odd no of 1 bits (8 bit))
	jpe JumpParityEven	;P=1 (Even no of 1 bits (8 bit))
	jmp $

JumpParityOdd:	
	mov al,'P'
	call printchar 
	mov al,'O'
	call printchar 
	jmp $

JumpParityEven:
	mov al,'P'
	call printchar 
	mov al,'E'
	call printchar 
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

TestConditionsCMPsigned:	
	mov al,10
	;mov bl,10		;AL=10
	mov bl,-15		;AL>-15
	;mov bl,15		;AL<15
	cmp al,bl
	call DoMonitorFlagsBXNL
	
	;jg jumped	;Jump if AX > cmp value 
	jge jumped	;Jump if AX >= cmp value 	
	;jl jumped	;Jump if AX < cmp value 
	;jle jumped	;Jump if AX <= cmp value 	
	jmp NoJump

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

TestConditionsCMPunsigned:	
	mov al,10
	;mov bl,10		;AL=10
	mov bl,5		;AL>5
	;mov bl,15		;AL<5
	
	cmp al,bl
	
	call DoMonitorFlagsBXNL
	
	ja jumped	;Jump if AX > cmp value  (JNC)
	;jae jumped	;Jump if AX >= cmp value 	
	;jb jumped	;Jump if AX < cmp value  (JC)
	;jbe jumped	;Jump if AX <= cmp value 	
	jmp NoJump
	
NoJump:	
	mov al,'.'
	call printchar 
	jmp $
jumped:
	mov al,'J'
	call printchar 
	
	
	jmp $
	
SomeData: 
	dw 1234h			;2 bytes of data
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

DoMonitorFlagsNL:
	pushf
		call DoMonitorAX
	popf
	pushf
		call DoMonitorFlags
		call newline
	popf
	ret
DoMonitorFlagsBXNL:
	pushf
		call DoMonitorAX
		call DoMonitorBX
	popf
	pushf
		call DoMonitorFlags
		call newline
	popf
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
	pop ax
	ret
DoMontiorCXAXFlags:
	pushf 
		call DoMonitorCX
		call DoMonitorAX
		
	popf
	pushf
		call DoMonitorFlags
		call newline
	popf
	ret
DoMonitorAXBX:				;Show AX+BX To the screen	
	call DoMonitorAX
	call DoMonitorBX
	call NewLine	
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
DoMonitorCX:				;Show AX To the screen
	push bx
	push ax
		mov al,'C'
		mov bx,cx
		jmp DoMonitorNX
	
include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

include \SrcALL\V1_Footer.asm

