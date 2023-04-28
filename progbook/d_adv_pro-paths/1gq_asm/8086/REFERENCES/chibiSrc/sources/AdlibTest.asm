include \SrcALL\V1_Header.asm

	call ScreenInit
	
	
	;mov ax, seg text
    mov ax, @data
	mov ds, ax
	
	mov ax, @code
    mov es, ax
	;call domonitor

	mov bh,0
	mov bl,0

	
	xor ax,ax
AdlibReset:
	call SetReg
	dec al
	jnz AdlibReset
	

	call DoPauseL
	
	call ToneTest
	
	call DoPauseL
	
	call DrumTest

	call DoPauseL
	
	call ToneTest
	
	call DoPauseL
	
	call DrumTest
	
	call DoPauseL
	
	call CymbTest	
	jmp $
	
	
SetRegPair:			;Set Adlib Reg AL = AH
	push ax
		call SetReg		;Set OP1
	pop ax
	add al,3			;Set OP2
SetReg:
	push ax
		mov dx,0388h	;Adlib port
		
		out dx,al		;388 = Address
		mov al,ah
		inc dx			;389 = Data
		out dx,al
	pop ax
	ret

	
	
ToneTest:	
;Set up Operations (addr and addr+3)
	
	mov al,020h			;Multi / Key Scale Rate / EG-Type Tone 
							;Vibrato / AM modulation
		;  AVEKMMMM	A=AM V=VIB E=EG-Typ K=KSR M=Multiple
	mov ah,00000001b
	call SetRegPair
	
	mov al,040h
		;  KKTTTTTT	K=KeyScaleLevel T=Total Level
	mov ah,00000000b	;Total Level / Key Scale Level
	call SetRegPair
	
	mov al,060h
		;  AAAADDDD	A=Attack D=Decay
	mov ah,11110000b	;Decay Rate / Attack Rate
	call SetRegPair
	
	mov al,080h
		;  SSSSRRRR	S=Sustain R=Release
	mov ah,11110100b	;Release Rate / Sustain Level
	call SetRegPair
	
	mov al,0E0h
		;  ------WW	WW=Wave Select
	mov ah,00000000b	;Wave Select 
	call SetReg

;Set up Channel	
	
	mov al,0C0h
		;  ----FFFC	F=Feedback C=Connection (op combination mode)
	mov ah,00100000b	;FeedBack factor / C=Connection sine/fm
	call SetReg
	
	mov al,0A0h			
		;  FFFFFFFF	F=Fnumber L
	mov ah,11111111b 	;F number 
	call SetReg
	
	mov al,0B0h
		;  --KBBBFF	F=Fnumber H B=Block K=K-on - Channel ON
	mov ah,00101000b	;Block / K-ON
	call SetReg
	
	call DoPause
	
	mov al,0B0h
		;  --KBBBFF	F=Fnumber H B=Block K=K-on - Channel OFF
	mov ah,00001000b	;Block / K-ON
	call SetReg
	ret

DoPauseL:
	mov cx,0FFFFh
DelayL:
	mov bx,25
DelayL2:	
	dec bx
	jne DelayL2
	
	loop DelayL
	ret

DoPause:
	mov cx,1000h
Delay3:
	loop Delay3
	ret
	
	
DrumTest:
;Set up Operations (addr and addr+3)
	
	mov al,030h			;Multi / Key Scale Rate / EG-Type Tone 
							;/ Vibrato / AM modulation
		;  AVEKMMMM	A=AM V=VIB E=EG-Typ K=KSR M=Multiple
	mov ah,00000001b
	call SetRegPair
	
	mov al,050h
		;  KKTTTTTT	K=KeyScaleLevel T=Total Level
	mov ah,00000000b	;Total Level / Key Scale Level
	call SetRegPair
	
	mov al,070h
		;  AAAADDDD	A=Attack D=Decay
	mov ah,11110000b	;Decay Rate / Attack Rate
	call SetRegPair
	
	mov al,090h
		;  SSSSRRRR	S=Sustain R=Release
	mov ah,00000100b	;Release Rate / Sustain Level
	call SetRegPair
	
	mov al,0F0h
		;  ------WW	WW=Wave Select
	mov ah,00000000b	;Wave Select 
	call SetReg

;Set up Channel	
	
	mov al,0C6h
		;  ----FFFC	F=Feedback C=Connection (op combination mode)
	mov ah,00100110b	;FeedBack factor / C=Connection sine/fm
	call SetReg
	
	mov al,0A6h			
		;  FFFFFFFF	F=Fnumber L
	mov ah,01111111b 	;F number 
	call SetReg
	
	mov al,0BDh
		;  DDRBSTCH	D=Depth (AM/VIB) R=Rythem B=Bass(13,16) 
					;S=Snare(17) T=Tom(15) C=Cymbal(18) H=Hihat(14)
	mov ah,00110000b	;Rythem mode (Chn 7-9) / Vibrato Depth /
	call SetReg				;AM Depth
	
	call DoPause
	
	mov al,0BDh
		;  DDRBSTCH	D=Depth (AM/VIB) R=Rythem B=Bass(13,16) 
					;S=Snare(17) T=Tom(15) C=Cymbal(18) H=Hihat(14)
	mov ah,00100000b	;Rythem mode (Chn 7-9) / Vibrato Depth /
	call SetReg				;AM Depth
	ret

	
	
	
CymbTest:
;Set up Operations (addr and addr+3)
	
	mov al,035h			;Multi / Key Scale Rate / EG-Type Tone / Vibrato / AM modulation
		;  AVEKMMMM	A=AM V=VIB E=EG-Typ K=KSR M=Multiple
	mov ah,00001000b
	call SetReg
	
	mov al,055h
		;  KKTTTTTT	K=KeyScaleLevel T=Total Level
	mov ah,00000000b	;Total Level / Key Scale Level
	call SetReg
	
	mov al,075h
		;  AAAADDDD	A=Attack D=Decay
	mov ah,11110000b	;Decay Rate / Attack Rate
	call SetReg
	
	mov al,095h
		;  SSSSRRRR	S=Sustain R=Release
	mov ah,00000100b	;Release Rate / Sustain Level
	call SetReg
	
	mov al,0F5h
		;  ------WW	WW=Wave Select
	mov ah,00000000b	;Wave Select 
	call SetReg

;Set up Channel	
	
	mov al,0C8h
		;  ----FFFC	F=Feedback C=Connection (op combination mode)
	mov ah,00101110b	;FeedBack factor / C=Connection sine/fm
	call SetReg
	
	mov al,0A8h			
		;  FFFFFFFF	F=Fnumber L
	mov ah,11111111b 	;F number 
	call SetReg
		
	mov al,0BDh
		;  DDRBSTCH	D=Depth (AM/VIB) R=Rythem B=Bass(13,16) 
					;S=Snare(17) T=Tom(15) C=Cymbal(18) H=Hihat(14)
	mov ah,00100010b	;Rythem mode (Chn 7-9) / Vibrato Depth / AM Depth
	call SetReg
	
	call DoPause
		
	mov al,0BDh
		;  DDRBSTCH	D=Depth (AM/VIB) R=Rythem B=Bass(13,16) 
					;S=Snare(17) T=Tom(15) C=Cymbal(18) H=Hihat(14)
	mov ah,00100000b	;Rythem mode (Chn 7-9) / Vibrato Depth / AM Depth
	call SetReg
	
	ret
	
	
	
	
include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

BitmapTest:
	ifdef BuildWSC
		incbin "\resALL\SpriteTestWSW4BppPlanar.RAW"
		;incbin "\resALL\SpriteTestWSW4BppLinear.RAW"
	endif
	ifdef BuildWSW
		incbin "\resALL\SpriteTestWSW2BppPlanar.RAW"
		;incbin "\resALL\SpriteTestWSW2BppLinear.RAW"		;Doesn't seem like Packed on BW wonderswan works!
	endif
	
	ifdef BuildDOS
		ifdef DosCGA
			incbin "\resALL\SpriteTestCGA.RAW"
		endif
		ifdef DosEGA
			incbin "\resALL\SpriteTestEGA.RAW"
		endif
		ifdef DosVGA
			incbin "\resALL\SpriteTestVGA.RAW"
		endif
	endif
	
BitmapTestEnd:


Palette:
	dw 0250h;0  -GRB
	dw 0000h;1  -GRB
	dw 0555h;2  -GRB
	dw 0AAAh;3  -GRB
	dw 0FFFh;4  -GRB
	dw 0826h;5  -GRB
	dw 0D33h;6  -GRB
	dw 03E3h;7  -GRB
	dw 07E6h;8  -GRB
	dw 0AE5h;9  -GRB
	dw 0FF4h;10  -GRB
	dw 02AAh;11  -GRB
	dw 00FFh;12  -GRB
	dw 030Dh;13  -GRB
	dw 063Bh;14  -GRB
	dw 0D0Fh;15  -GRB


include \SrcALL\V1_Footer.asm
;end start

