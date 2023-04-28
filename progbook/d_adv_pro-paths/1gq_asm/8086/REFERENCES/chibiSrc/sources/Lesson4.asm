
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

include \SrcALL\V1_Header.asm

Use2ndStack	macro 
	mov di,sp
	mov sp,offset TestStack2	;Second stack so our dump routine doesn't corrupt the real one
	mov si,seg TestStack 
	mov es,si
endm
DoMonitorAXBitsFlags macro
	Use2ndStack
	call DDoMonitorAXBitsFlags
	mov sp,di
endm 

DoDumpTestStack	macro 
	Use2ndStack
	push bx
		call newline
		mov bp,offset TestStack-16
		mov bx,16
		call MemDump			;Dump [es:bp] for bx bytes
		call newline
	pop bx
	mov sp,di
endm
DoMonitorAXBX	macro 
		DoMonitorAX
		DoMonitorBX
		DoNewLine
endm
DoMonitorAXBXSP	macro 
		DoMonitorAX
		DoMonitorBX
		DoMonitorSP
		DoNewLine
endm



DoMonitorAX	macro 
		Use2ndStack
		call DDoMonitorAX
		mov sp,di
endm
DoMonitorBX	macro 
		Use2ndStack
		call DDoMonitorBX
		mov sp,di
endm
DoMonitorIP	macro 
		Use2ndStack
		call DDoMonitorIP
		mov sp,di
endm
DoMonitorSP	macro 
		Use2ndStack
		call DDoMonitorSP
		mov sp,di
endm

DoNewLine	macro 
	Use2ndStack
	call newline
	mov sp,di
endm

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	mov ax, @data		;ES points to our Data segment
	mov ds, ax
	
	mov ax, @code		;DS points to our Code segment
    mov es, ax
	
	call ScreenInit
	
	
	
	mov ax,seg TestStack		;Load the Stack Segment as our test stack
	mov ss,ax
	mov sp,offset TestStack		;Set the stack pointer to the end of the stack

	
	DoDumpTestStack

	;jmp StackTest				;Basic Stack tests
	;jmp StackTestFlags			;Flags Stack test
	;jmp TestNestedPushes		;Test Nested Pushes
	;jmp TestNestedCalls			;Test Calls
	;jmp TestCallReturn			;Use a Return with parameter
	jmp TestMacro
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
Macro1	macro 
	call DDoMonitorAX
	call DDoMonitorBX
	call DDoMonitorIP
	call DDoMonitorSP
	call NewLine
endm

Macro2 Macro p1,p2
	mov ax,p1
	mov bx,p2
	call DDoMonitorAX
	call DDoMonitorBX
	call NewLine
endm

TestMacro:	
	mov ax,1
	mov bx,2
	Macro1
	push ax
		mov ax,3
		mov bx,4
		Macro1
	pop ax
	
	Macro2 0FFFFh,0EEEEh
	Macro2 01111h,02222h
	
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
StackTest:	
	mov ax,01234h			;Load a value into AX
	DoMonitorAX
	push ax					;Back it up
		mov ax,05678h		;Change AX
		DoMonitorAX
	pop ax					;Restore the old value
	DoMonitorAX
	DoNewLine
	DoDumpTestStack
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	mov ax,01234h			;Load values into AX+BX
	mov bx,0ABCDh
	DoMonitorAXBXSP
	push ax					;Back up AX+BX 
	push bx
		mov ax,05678h		;Change AX+BX
		mov bx,0FFEEh
		DoMonitorAXBXSP
	pop bx					;Restore up AX+BX
	pop ax
	DoMonitorAXBXSP
	DoDumpTestStack
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	mov ax,01234h			;Load values into AX+BX
	mov bx,0ABCDh
	DoMonitorAXBX
	push ax					;Back up AX+BX 
	push bx
		mov ax,05678h		;Change AX+BX
		mov bx,0FFEEh
		DoMonitorAXBX
	pop ax	;We popped off the stack in the wrong order
	pop bx				;AX and BX will be reversed
	DoMonitorAXBX	
	DoNewLine
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	


	
StackTestFlags:	
	mov ax,0000h
	DoMonitorAXBitsFlags
	pushf					;Back up flags
		mov ax,0FFFFh
		sahf 				;store AH in flags
		DoMonitorAXBitsFlags
		mov ax,0000h
		sahf 				;store AH in flags
		DoMonitorAXBitsFlags
		push ax				;Uset stack to clear all flags
		popf
		DoMonitorAXBitsFlags
	popf					;Restore Flags
	
	lahf					;Load AH from the flags
	DoMonitorAXBitsFlags
	
	pushf
	pop ax	;Use the stack to load AX with the Flags
	DoMonitorAXBitsFlags
	DoDumpTestStack
	
	jmp $

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

TestNestedCalls:
	mov ax,0x0000			;Zero AX+BX
	mov bx,0x0000
	DoMonitorIP
	DoMonitorAXBX
	
	DoMonitorIP
	call TestNestedCall1	;Call First Sub (Return address onto stack)
	
	DoMonitorIP	
	DoMonitorAXBX
	DoDumpTestStack			;Show final stack
	jmp $
	
TestNestedCall1:	
	push bx					;Backup BX
		call TestNestedCall2 ;Call 2nd Sub (Return address onto stack)
		DoMonitorIP
		call TestNestedCall2 ;Call 2nd Sub (Return address onto stack)	
	pop bx					;Restore BX (Changes by sub are lost)
	add ax,0x10		
	add bx,0x10				;Add 10 to AX+BX
	ret

TestNestedCall2:	
	add ax,0x1				;Add 1 to AX+BX
	add bx,0x1	
	DoMonitorAXBX
	ret


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
TestNestedPushes:
	mov ax,1234h			;Push 1234 onto stack
	DoMonitorAX
	push ax
		mov ax,5678h		;Push 5678 onto stack
		DoMonitorAX
		push ax
			mov ax,9ABCh	;Push 9ABC onto stack
			DoMonitorAX
			push ax
				DoNewLine
				DoNewLine
				mov ax,0DEF0h	;Final State.
				DoMonitorAX
				DoNewLine
				DoNewLine
			pop ax			;Pop off 9ABC
			DoMonitorAX
		pop ax 				;Pop off 5678
		DoMonitorAX
	pop ax					;Pop off 1234
	DoMonitorAX
	DoDumpTestStack			;Show final stack	
	
	jmp $
	

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	
TestCallReturn:
	donewline 
	call TestCallStackTest
	call domonitor
	donewline 
	
	mov ax,0FEDCh
	push ax					;We'll pop this onto the stack later
	mov ax,0BA98h
	push ax					;We'll pop this onto the stack later
	call TestCallRet
	call domonitor

	jmp $
	
TestCallStackTest:		
	mov ax,0000h			;Normal return
	ret 
	
TestCallRet:
	mov si,sp
	mov cx,[ss:si+2]
	mov dx,[ss:si+4]
	ret 4		;Remove the 2 params (4 bytes) from the stack

	
	byte 128 dup (0)
TestStack:	
	byte 128 dup (0)
TestStack2:	





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

	
DDoMonitorAXBitsFlags:				;Show AX+BX To the screen	
	push ax
		pushf
			call DDoMonitorAX
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
DDoMonitorIP:				;Show AX To the screen
	push ax
	push bx
		inc sp
		inc sp
		inc sp
		inc sp
		pop bx
		push bx
		dec sp
		dec sp
		dec sp
		dec sp
		mov ax,'PI'
		call DoMonitorOne
	pop bx
	pop ax
	ret

DdoMonitorSP:
	push ax
	push bx
		mov ax,'PS'
		mov bx,di
		call DoMonitorOne
	pop bx
	pop ax
	ret
		
DDoMonitorAX:				;Show AX To the screen
	push bx
	push ax
		mov bx,ax
		mov al,'A'
DoMonitorNX:
		call DoMonitorOneX	;Function in the Monitor - shows [AL]X:BX
	pop ax
	pop bx
	ret
	
DDoMonitorBX:				;Show AX To the screen
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

