include \SrcALL\V1_Header.asm

	call ScreenInit
	
	ifdef BuildWSW
		call ChibiSound_Init
	endif
	
	;mov ax, seg text
    mov ax, @data
	mov ds, ax
	
	mov ax, @code
    mov es, ax
	;call domonitor
	
InfLoop:
	mov bh,0
	mov bl,0
	call Locate
	
	call doMonitor
	
	push ax
		Call ChibiSound
	pop ax
	
	inc al
	
	mov bx,000h
Delay:
	dec bx
	jnz Delay	
	jmp InfLoop
	
	ifdef BuildWSW
		include \SrcWSW\V1_ChibiSound.asm	
	else
		include \SrcDOS\V1_ChibiSoundAdlib.asm
		;include \SrcDOS\V1_ChibiSound.asm	
	endif
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

