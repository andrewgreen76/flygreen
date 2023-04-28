;sbbase=220
;irq=7
;dma=1

;388 Reg 389 Data
	
ChibiSound:   ;NVTTTTTT	Noise Volume Tone (N=1 highest pitch)
	
	cmp al,0
	je ChibiSound_Silent
	
	mov ah,00000000b			;Total Level / Key Scale Level
	
	push ax
		and al,01000000b		;Volume bit
		jnz ChibiSound_Quiet
				;  KKTTTTTT	K=KeyScaleLevel T=Total Level
			mov ah,00001000b	;Total Level / Key Scale Level
ChibiSound_Quiet:	
	
		mov al,040h
		call SetRegPair			;Set volume
		
		
		mov al,020h			;Multi / Key Scale Rate / EG-Type Tone 
								;Vibrato / AM modulation
			;  AVEKMMMM	A=AM V=VIB E=EG-Typ K=KSR M=Multiple
		mov ah,00000001b
		call SetRegPair
			
		mov al,060h
			;  AAAADDDD	A=Attack D=Decay
		mov ah,11110000b	;Decay Rate / Attack Rate
		call SetRegPair
		
		mov al,080h
			;  SSSSRRRR	S=Sustain R=Release
		mov ah,11111100b	;Release Rate / Sustain Level
		call SetRegPair
		
		mov al,0E0h
			;  ------WW	WW=Wave Select
		mov ah,00000000b	;Wave Select 
		call SetReg

		
	pop ax
	push ax
		mov ah,al
		
		shl ah,1
		shl ah,1
		
		mov al,0A0h			
			;  FFFFFFFF	F=Fnumber L
		xor ah,11111111b 	;F number 
		call SetReg

		
	pop ax
	and al,10000000b	;Noise Bit
	
		;  ----FFFC	F=Feedback C=Connection (op combination mode)
	mov ah,00100000b	;FeedBack factor / C=Connection sine/fm
	
	jz ChibiSoundNoNoise
			;  ----FFFC	F=Feedback C=Connection (op combination mode)
		mov ah,00100110b	;FeedBack factor / C=Connection sine/fm
ChibiSoundNoNoise:	
	mov al,0C0h
	call SetReg
		
		
	mov al,0B0h
		;  --KBBBFF	F=Fnumber H B=Block K=K-on
	mov ah,00101001b	;Block / K-ON	- Sound ON
	jmp SetReg	
	
	
	
ChibiSound_Silent:	
	mov al,0B0h
		;  --KBBBFF	F=Fnumber H B=Block K=K-on
	mov ah,00001000b	;Block / K-ON   - Sound OFF
	jmp SetReg


	
SetRegPair:
	call SetReg
	add al,3
SetReg:
	push ax
		mov dx,0388h	;Adlib port
		
		out dx,al		;388 = Address
		mov al,ah
		inc dx			;389 = Data
		out dx,al
	pop ax
	ret

	