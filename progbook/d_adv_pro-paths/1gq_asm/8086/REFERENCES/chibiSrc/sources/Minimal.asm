include \SrcALL\V1_Header.asm

	mov ax, @data		;ES points to our Data segment
	mov ds, ax
	
	mov ax, @code		;DS points to our Code segment
    mov es, ax
	

	call ScreenInit
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
	call Domonitor		;Show all registers to screen
	
infloop:
	jmp infloop
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

include \SrcALL\V1_Footer.asm

