
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

include \SrcALL\V1_Header.asm

	call ScreenInit
	;jmp MultiplyTest	;MULtiply Test
	;jmp DivideTest
	;jmp PortTest		;IN and OUT test
	
	;jmp InterruptTest		;Interrupt test

	jmp AddSubWithCarryTest	;We can use ADC and SBB to do 32 bit+ addition/Subtraction
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;				
AddSubWithCarryTest:	
	mov ax,00000h		;AX.BX=0000 FFF8h
	mov bx,0FFFAh
	mov cx,00001h			;CX.DX=0001 0001h
	mov dx,00001h
	push ax				;Clear the flags
	popf
	
	call DoMonitorAXBXCXDX	;Show the results
	call DoMonitorFlags
	call DoMonitorAXBXFlags
	call newline
	
	mov di,8				;Loop Count 
	
AddAgain:
	add bx,dx				;ADD 32 bit pair CX.DX to AX.BX
	call DoMonitorFlags
	adc ax,cx				;Add any 'carry' from ADD command
	call DoMonitorAXBXFlags
	dec di
	jnz AddAgain
	
	call newline 
	
	call DoMonitorAXBXCXDX	;Show the results
	call DoMonitorFlags
	call DoMonitorAXBXFlags
	call newline
	
	mov di,8				;Loop Count 
	
SubAgain:
	sub bx,dx				;ADD 32 bit pair CX.DX to AX.BX
	call DoMonitorFlags
	sbb ax,cx				;Add any 'borrow' from SUB command
	call DoMonitorAXBXFlags
	dec di
	jnz SubAgain
	
	jmp $
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;			
		;DIVide test
		
		
		
DivideTest:
	mov dx,0
	mov es,dx
	
	
	mov dx,seg err
	mov [es:0012h],dx	;int4 CS
	mov dx,offset err
	mov [es:0010h],dx	;int4 IP
	
	mov dx,seg err
	mov [es:002h],dx
	mov dx,offset err
	mov [es:000h],dx
	
	int 4
	
	mov dx,0h
	mov ax,0ff83h			
	mov bx,10h
	call DoMonitorAXBXDX	;FF83h = -125	
	idiv bl					;AX=Ah*bl (Signed)
	call DoMonitorAXBXDX	;F9h = -7 / Rem: F3h =-13
	
	
	mov dx,0ffffh
	mov ax,0f803h			
	mov bx,10h
	call DoMonitorAXBXDX	;F803h = -2045	
	idiv bx					;AX=Ah*bl (Signed)
	call DoMonitorAXBXDX	;FF81h = -127 / Rem: FFF3h =-13
	
	call NewLine	
	
	mov dx,0h
	mov ax,00f83h			
	mov bx,10h
	call DoMonitorAXBXDX	;FF83h = -125	
	div bl					;AX=Ah*bl (Signed)
	call DoMonitorAXBXDX	;F9h = -7 / Rem: F3h =-13
	
	
	mov dx,0ffffh
	mov ax,0f803h			
	mov bx,1h
	call DoMonitorAXBXDX	;F803h = -2045	
	div [myval]					;AX=Ah*bl (Signed)
	call DoMonitorAXBXDX	;FF81h = -127 / Rem: FFF3h =-13
	
	
	
	
	jmp $
myval db 1h
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
InterruptTest:

	mov dx,0
	mov es,dx			;Segment 0
	
	
	mov dx,seg int4
	mov [es:0012h],dx	;int4 CS
	mov dx,offset int4
	mov [es:0010h],dx	;int4 IP
	
	mov dx,seg StepTrap
	mov [es:0006h],dx	;int2 CS	;Debugging step - occurs every command when trap flag set
	mov dx,offset StepTrap
	mov [es:0004h],dx	;int2 IP
	
	int 4
	int 4
	int 4
	
	call NewLine

	pushf
		mov bp,sp
		or word ptr [bp],0100h ; Set Trap flag (T)
	popf
	
	mov ax,01234h
	mov ax,05678h
	mov ax,09ABCh
	
	
	
	
	mov ax,0000h		;Clear the trap flag
	push ax
	popf 
	
	;popf
		;mov bp,sp
		;and word ptr [bp],0FEFFh ; Clear Trap flag (T)
	;popf
	
	
	Call DoMonitor
	
	jmp $
int4:
	push ax
		mov al,'I'
		call printchar
		mov al,'n'
		call printchar
		mov al,'t'
		call printchar
		mov al,'4'
		call printchar
	pop ax
	iret
StepTrap:
	call DoMonitorAX
		
	iret	;Return and pop flags
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
		;MULtiply Test
MultiplyTest:
	mov dx,0h
	mov ax,080h				
	mov bx,10h
	call DoMonitorAXBXDX	;  80h = -128
	imul bl					;AX=Ah*bl (Signed)
	call DoMonitorAXBXDX	;F800h = -2048
	
	call NewLine	

	mov ax,080h				
	mov bx,10h
	call DoMonitorAXBXDX	;  80h = 128
	mul bl					;AX=Ah*bl (Unsigned)
	call DoMonitorAXBXDX	; 800h = 2048
	
	call NewLine	
	
	mov ax,0010h
	mov bx,8000h
	call DoMonitorAXBXDX	;8000h	   = -32768
	imul bx					;DX.AX=AX*BX (Signed)
	call DoMonitorAXBXDX	;fff80000h = -524288
	
	call NewLine	
	
	mov ax,0010h
	mov bx,8000h
	call DoMonitorAXBXDX	;8000h	= 32768
	mul bx					;DX.AX=AX*BX (Unigned)
	call DoMonitorAXBXDX	;80000h = 524288
	
	jmp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
		;port Test
PortTest:

			;   CCAAMMMS  C=Counter select,  A=counter Access, M=counter Mode, S=counter Style
	mov al, 10110110b   ;M=2 - square wave...  AA=3 Write LH Bytes to 42h... C=2 - Counter 2 select
	out 43h, al        
	
	mov ax, 4096        ;Tone we want to send.
						
	out 42h, al       	;L Byte - 0042  RW  PIT  counter 2, cassette & speaker	(XT, AT, PS/2)
	mov al, ah  		;Send High Byte
	out 42h, al 		;H Byte - 0042  RW  PIT  counter 2, cassette & speaker	(XT, AT, PS/2)

	mov ax,0
	in al, 61h      	;Get status of KB controller port B control register 
	call DoMonitorAX
		;   R---PPST 	 R=Reset P= parity checks S=Speaker enable T=speaker Timer 
	or al, 00000011b	;Lets turn on the speaker   
	
	out 61h, al      	;Update status of KB controller port B control register 
	
	mov bx, 20         	;Pause for note
	mov cx, 0
pauser:	
	;nop				;Do nothing (a delay)
	;nop
	;nop
	dec cx				;Pause for 65536
	jne pauser
	dec bx				;pause for 20
	jne pauser
	
	mov ax,0
	
	in      al, 61h         ;Get status of KB controller port B control register 
	call DoMonitorAX
	
			;   R---PPST 	 R=Reset P= parity checks S=Speaker enable T=speaker Timer 
	and     al, 11111100b   ;Turn off the speaker 
	
	out     61h, al         ;Update status of KB controller port B control register 
	jmp $
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

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
		mov al,' '
		call printchar
	popf	
	pop ax
	ret

DoMonitorAXBXCXDX:
	pushf
		call DoMonitorAX
		call DoMonitorBX
		call DoMonitorCX
		call DoMonitorDX
		call DoMonitorFlags
		call NewLine	
	popf
	ret
	
DoMonitorAXBXFlags:
	pushf
		
		call DoMonitorAX
		call DoMonitorBX
	popf
	pushf
		call DoMonitorFlags
		call NewLine	
	popf
	ret

	
DoMonitorAXBXDX:				;Show AX+BX To the screen	
	call DoMonitorDX
	call DoMonitorAX
	call DoMonitorBX
	
	call NewLine	
	ret
err:
	
		mov al,'E'
		call printchar
		mov al,'r'
		call printchar
		mov al,'r'
		call printchar
	pop ax
	inc ax
	push ax
	mov ax,0
	
	iret
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

		
DoMonitorDX:
	push bx
	push ax	
		mov al,'D'
		mov bx,dx
		jmp DoMonitorNX
	
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
