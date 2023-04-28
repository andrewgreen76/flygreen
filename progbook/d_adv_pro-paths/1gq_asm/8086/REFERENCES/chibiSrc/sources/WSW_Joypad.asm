mains segment

@data 	equ 00000h
UserRam equ 00100h
@code 	equ 0F000h

SmallScreen equ 1
		
CursorX			equ UserRam
CursorY			equ UserRam+1

MonitorBak_AX 	equ UserRam+2
MonitorBak_F	equ UserRam+4
MonitorBak_IP   equ UserRam+6
MonitorBak_ES   equ UserRam+8
MonitorBak_DS   equ UserRam+8


ProgramStart:		;Needed for header
	cli
	xor		ax,ax
	mov		ss,ax
	mov		sp,0x8000
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	xor ax,ax		;ax=0
	out	00h,ax		;REG_DISP_CTRL - Turn off layers

;Enable Graphics mode + WSC functions	
	ifdef BuildWSC
			  ;BCP0-0--  B=bpp (1=4bpp) C=color (1=WSC)  P=planar (0=yes)
		mov al,11000000b ;DISP_MODE_4BPP + DISP_MODE_COL + DISP_MODE_PLANAR
	else
			  ;BCP0-0--  B=bpp (1=4bpp) C=color (1=WSC)  P=planar (0=yes)
		mov al,00000000b ;DISP_MODE_PLANAR	
	endif
	out 60h,al 			;REG_DISP_MODE

;Transfer font to pattern ram
	xor ax,ax	
	mov es,ax			;segment 0 (RAM) is implied	
	ifdef BuildWSC
		mov di,4000h 	;RAM_4BPP_TILES_BANK0_BASE
	else
		mov di,2000h 	;RAM_4BPP_TILES_BANK0_BASE
	endif
	mov ax,0f000h		;Cartridge segment
	mov ds,ax
	mov si,BitmapFont
	mov cx,BitmapFontEnd-BitmapFont
	
CopyFontAgain:
	mov al,[ds:si]		;Get font line
	mov [es:di],al		;2 bitplanes - all the same!
	inc di	
	mov [es:di],al		;2 bitplanes - all the same!
	inc di
	ifdef BuildWSC
		mov [es:di],al	;4 bitplanes - all the same!
		inc di
		mov [es:di],al	;4 bitplanes - all the same!
		inc di
	endif
	inc si				;Next line of font
	Loop CopyFontAgain
	
	ifdef BuildWSC			;Copy palette to vram
		xor ax,ax	
		mov es,ax	 		;segment 0 (RAM) is implied	
		mov di,0fe00h 		;RAM_4BPP_PALETTE_BASE

		mov ax,0f000h		;Source = ROM
		mov ds,ax
		mov si,WSCpalette	;-RGB one nibble per channel
		mov cx,16
		cld					;Inc mode
		rep movsw			;transfer color palettes	
	else
		mov al,0	;CCC (WS) Color / PPPPIIII (WSC) Pool/Index
		out 01h,al	;Background color to 0 - For Transp areas
		
;Define 8 colors for our palette (F=Black 0=White)
		mov al,20h			;11110000
		out 1ch,al			;REG_PALMONO_POOL_0
		
		mov al,46h			;33332222
		out 1dh,al			;REG_PALMONO_POOL_1
		
		mov al,0A8h			;55554444
		out 1eh,al			;REG_PALMONO_POOL_2
		
		mov al,0FCh			;77776666
		out 1fh,al			;REG_PALMONO_POOL_3
		
;Select from those 8 colors to make our palette
		;mov ax,7530h		;Black on White  background
		mov ax,0357h		;White on Black background
		out 020h,ax			;Palette 0 - REG_PALMONO_0 HL
	endif
	
;Clear the map
	xor ax,ax		
	mov es,ax		;segment 0 (RAM) 
	mov di,1000h	;SCR1 Tilemap
	mov ax,0		;Tile 0 (VHBPPPPT TTTTTTT)
	mov cx,32*32 	;MAP_WIDTH_CH*MAP_HEIGHT_CH
	cld			
	rep stosw
	
;Init Screen
	xor ax,ax		; reset scrolling
	out 10h,ax		;REG_SCR1_X
	out 11h,ax		;REG_SCR1_Y

		;  21
	mov al,32h		;Screen Base   WS:%-222-111 SCR2, SCR1 
	out 07h,al		;REG_MAP_BASE WSC:%22221111 SCR2, SCR1 

		 ;%--EMWS21 1=Scr 1 2=Scr2 S=Sprite on / W=SprWin on / M=Scr2 Win Mode / E=Scr2 Win Enable
	mov al,00000001b		;DISP_CTRL_SCR1_EN enable SCR1
	out 00h,al		;REG_DISP_CTRL 

	ifdef BuildWSC
		in al,14h 	;REG_LCD_CTRL	
		or al,1		;LCD_CTRL_LCD_ON (1=High Contrast)
		out 14h,al	;REG_LCD_CTRL
	endif
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	
    mov ax, @data
	mov ds, ax
	
	mov ax, @code
    mov es, ax
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
Again:	
	mov	byte ptr [ds:CursorX],0			;Zero Cursor Pos
	mov	byte ptr [ds:CursorY],0
	mov bx,0

;Read directions BX= ----RLDU-BASRLDU
	
;Read Y Pad	
		;  -LLLDDDD
	mov al,00010000b	;Y Pad
	out 0b5h,al			;Select
	in al,0b5h			;Read Ypad
	  	  ;----LDRU	
	and ax,00001111b	;Mask Direction bits
	rol ax,8			;Shift into pos
	or bx,ax			;Store in B
;Read X Pad
		;  -LLLDDDD
	mov al,00100000b	;X Pad
	out 0b5h,al			;Select
	in al,0b5h			;Read Xpad
	  	   ;----LDRU
	and ax,00001111b	;Mask Direction bits
	or bx,ax			;Store in B
;Read Buttons
		;  -LLLDDDD
	mov al,01000000b	;Buttons
	out 0b5h,al			;Select
	in al,0b5h			;Read Buttons
		  ;----BAS-
	and ax,00001110b	;Mask Button bits 
	rol ax,3			;Shift into pos
	or bx,ax			;Store in B
	
	Call DoMonitor		;Show Registers
	
	jmp Again
	
HelloMsg:
	byte "Hello World",255

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	
PrintString:
	mov al,[es:si]
	cmp al,255
	jz PrintString_Done
	call PrintChar
	inc si
	jmp PrintString
PrintString_Done:
	ret
	
	
	
include \SrcAll\V1_Monitor.asm	



BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:
	


PrintChar:
	push di
	mov di,1000h
	push es
	push ds
	push ax
		push ax
			xor		ax,ax
			mov		es,ax		
			mov		ds,ax		
			mov	al,[ds:CursorX]
			mov ah,0
			sal ax,1
			add di,ax
			
			mov	al,[ds:CursorY]
			mov ah,0
			sal ax,6			;32 columns, 2 bytes per column
			add di,ax
		pop ax
		sub al,32
		mov ah,00000000b			;Palette Flip Etc
		mov WORD PTR [ds:di],ax		;VHBPPPPT TTTTTTT - Tile / Palette / wsc Bank  / Hflip / Vflip
		inc BYTE PTR [ds:CursorX]
		cmp byte ptr [ds:CursorX],28
		jne PrintCharNoNewLine
		call NewLine
PrintCharNoNewLine:
	pop ax
	pop ds
	pop es
	pop di
	ret

NewLine:
	mov BYTE PTR [ds:CursorX],0
	inc BYTE PTR [ds:CursorY]
	ret
	
PrintSpace:
	push ax
		mov al,' '	;Print a Space to the screen
		call PrintChar	
	pop ax
	ret	
		
	ifdef BuildWSC
WSCpalette:		
		;  	 -RGB
		dw 0x000F	;0
		dw 0x00FF	;1
		dw 0x0F00	;2
		dw 0x0FFF	;3
		dw 0x0FFF	;4
		dw 0x0FFF	;5
		dw 0x0FFF	;6
		dw 0x0FF0	;7
		dw 0x0F0F	;8
		dw 0x00FF	;9
		dw 0x0FFF	;A
		dw 0x00FF	;B
		dw 0x00FF	;C
		dw 0x00FF	;D
		dw 0x0FFF	;E
		dw 0x0FF0	;F
	endif

	

	
;	Rom Footer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	org 0xFFF0 ;(65520)
	
	db	0xEA			; jmp far
	dw	ProgramStart	; Entry point
	dw	0xF000			; In bank 0xF000
	db	0x00
	db	0xCD		; Developer ID
	db	0x01		; Color mode
	db	0x01		; Cart number
	db	0x00		; Reserved
	db	0x02		; Cart Size (4 Mb)
	db	0x00		; SRAM size (0 Kb)
	db	0x04		; Horizontal game
	db	0x00		; Additional capabilities
	dw	0x0000	; Checksum (?)
mains ends
