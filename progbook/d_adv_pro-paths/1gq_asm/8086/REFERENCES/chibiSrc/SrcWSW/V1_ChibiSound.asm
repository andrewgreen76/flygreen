
ChibiSound_Init:
	mov al,34h		;address >> 6. (0D00h>>6 = 34h)
	out 08fh,al		;REG_SND_WAVE_BASE
		
	mov ax,@data 
	mov es,ax
	mov di,0D30h	;D000=Chn1 D010=Chn2 D020=Chn3 D030=Chn4
	mov ax,0FFFFh	;4 bits per sample 
	STOSW			;32 samples (16 bytes) per channel
	STOSW
	mov ax,00000h
	STOSW	
	STOSW
	mov ax,0FFFFh	;We're making a square wave
	STOSW			;FFFFFFFF00000000FFFFFFFF00000000
	STOSW
	mov ax,00000h
	STOSW	
	STOSW
	ret
	
	

ChibiSound:
	cmp al,0
	jnz ChibiSound_NotSilent
	
		  ;NSV-4321		N= ch4 Noise / S= ch3 Sweep / V= ch2 Voice
	mov al,00000000b  	;M=Channel Modes / 4321 - Channel enable
	out 90h,al			;REG_SND_CTRL
	ret	
ChibiSound_NotSilent:			
	
	mov bl,al			;Backup for later
		;  C---HSSM
	mov al,00000001b	;C=headphone Connected, H=Headphone enable
							;S=volume Shift M=Main speaker
	out 091h,al			;G_SND_OUTPUT
	
;Set Volume	
		  ;LLLLRRRR
	mov al,10011001b	;L=Left R=Right
	
	test bl,01000000b
	jz ChibiSound_Quiet
		  ;LLLLRRRR
	mov al,11111111b	;L=Left R=Right
ChibiSound_Quiet:	
	out 8Bh,al			;REG_SND_CH4_VOL
	
;Set Frequency
	xor ax,ax
	mov al,bl
	not al
	and al,00111111b
	
	shl ax,4
	
	out 86h,al			;REG_SND_CH4_PITCH_L LLLLLLLL
	mov al,ah
	out 87h,al			;REG_SND_CH4_PITCH_H -----HHH

	test bl,10000000b
	jz ChibiSound_NoNoise
	
;Set Noise 	
		  ;NSV-4321		N= ch4 Noise / S= ch3 Sweep / V= ch2 Voice
	mov al,10001000b  	;M=Channel Modes / 4321 - Channel enable
	out 90h,al			;REG_SND_CTRL
	
		;  ---ERMMM		E=Enable / R=Reset / M=Mode
	mov al,00011000b
	out 08Eh,al			;REG_SND_NOISE	
	ret
	
ChibiSound_NoNoise:		
		  ;NSV-4321		N= ch4 Noise / S= ch3 Sweep / V= ch2 Voice
	mov al,00001000b  	;M=Channel Modes / 4321 - Channel enable
	out 90h,al			;REG_SND_CTRL
	ret
	
	