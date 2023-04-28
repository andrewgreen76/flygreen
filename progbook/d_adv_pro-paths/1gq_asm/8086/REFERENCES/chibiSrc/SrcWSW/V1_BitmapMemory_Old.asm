
PrintChar:
	push ax
		push ax
			xor		ax,ax
			mov		es,ax		
			mov	al,[es:CursorX]
			mov ah,0
			sal ax,1
			mov di,ax
			
			mov	al,[es:CursorY]
			mov ah,0
			sal ax,6			;32 columns, 2 bytes per column
			add di,ax
		pop ax
		sub al,32
		mov ah,00000000b			;Palette Flip Etc
		mov WORD PTR [es:di],ax		;VHBPPPPT TTTTTTT - Tile / Palette / wsc Bank  / Hflip / Vflip
		inc BYTE PTR [es:CursorX]
		cmp [es:CursorX],28
		jne PrintCharNoNewLine
		call NewLine
PrintCharNoNewLine:
	pop ax
	ret

ScreenInit:
	cli

	xor		ax,ax
	mov		bx,ax
	mov		cx,ax
	mov		dx,ax
	mov		es,ax
	mov		ds,ax
	mov		bp,ax
	mov		ss,ax
	mov		sp,0x800

	out		00,ax		;REG_DISP_CTRL - disable all layers
	

	; Copy font data
	xor 	ax,ax	
	mov		es,ax			;segment 0 (RAM) is implied	
	mov		di,2000h 		;2bpp tiles
	mov		ax,0f000h
	mov		ds,ax
	mov		si,BitmapFont
	mov		cx,BitmapFontEnd-BitmapFont
	cld			
	
CopyFontAgain:
	;movsw	
	mov al,[ds:si]
	mov [es:di],al			;2 bitplanes - all the same!
	inc di	
	mov [es:di],al
	inc di
	inc si
	Loop CopyFontAgain
	
	
	; This needs to happen before we copy the palette data, since
	; the upper 48kB of RAM only are available in Color mode.
			  ;BCP0-0-- - Planar Color Bpp
			  
	mov		al,00000000b  	;DISP_MODE_4BPP + DISP_MODE_COL + DISP_MODE_PLANAR
	out		60h,al 			;REG_DISP_MODE
	
	
	mov al,0			;CCC / PPPPIIII
	out 01h,al			;Background color to 0
	
	
	;Define 8 colors for our palette
	;F=Black 0=Whote
	
	mov al,20h			;11110000
	out 1ch,al			;Pool 0 to palette 0
	
	mov al,46h			;33332222
	out 1dh,al			;Pool 0 to palette 0
	
	mov al,0A8h			;55554444
	out 1eh,al			;Pool 0 to palette 0
	
	mov al,0FCh			;77776666
	out 1fh,al			;Pool 0 to palette 0
	
	
	;Select from those 8 colors to make our palette
	mov ax,7530h		;Palette 0 
	mov ax,0357h		;Palette 0 
	out 020h,ax
	
	
	; Copy  Color palette
	;MEMCPYW RAM_4BPP_PALETTE_BASE, 0xf000, palette, paletteSize/2
    ; xor 	ax,ax	
	; mov		es,ax	 		;segment 0 (RAM) is implied	
	; mov		di,0fe00h 		;RAM_4BPP_PALETTE_BASE
	; mov		ax,0f000h
	; mov		ds,ax
	; mov		si,palette
	; mov		cx,paletteSize/2
	; cld			
	; rep		movsw	

	
	
	
	; Clear the map
	;MEMSETW 0x0000, 0, MAP_WIDTH_CH*MAP_HEIGHT_CH
	xor		ax,ax		
	mov		es,ax		;segment 0 (RAM) is implied	
	mov		di,0000h
	mov		ax,0
	mov		cx,32*32 	;MAP_WIDTH_CH*MAP_HEIGHT_CH
	cld			
	rep		stosw
	
	
	xor		ax,ax					; reset scrolling
	out		10h,ax		;REG_SCR1_X
	out		11h,ax		;REG_SCR2_X
		
	mov		al,01h		;DISP_CTRL_SCR1_EN enable SCR1
	out		00h,al		;REG_DISP_CTRL

	mov		al,0		;LCD_ICON_SLEEP	
	out		15h,al		;REG_LCD_ICON

	in		al,14h 		;REG_LCD_CTRL	
	or		al,1		;LCD_CTRL_LCD_ON
	out		14h,al		;REG_LCD_CTRL

	xor 	ax, ax		;SCR maps at 0x0000
	out		07h,al		;REG_MAP_BASE
	
	
	ret


Locate:
		mov  BYTE PTR [es:CursorX],bh
		mov  BYTE PTR [es:CursorY],bl
	ret
NewLine:
		mov  BYTE PTR [es:CursorX],0
		inc  BYTE PTR [es:CursorY]
	ret
	
PrintSpace:
	push ax
		mov al,' '
		call PrintChar
	pop ax
	ret	

	
palette:		;dw WSC_COLOR(4,3,10), WSC_COLOR(8,7,13)
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
			dw 0x0FFF	;10
			dw 0x0FFF	;11
			dw 0x0FFF	;12
			dw 0x0FFF	;13
			dw 0x0FFF	;14
			dw 0x0FF0	;15
			
paletteSize equ $ - palette

DefineTiles:			;CX=byte Count
						;DS:SI=source Data
						;AX= Dest Tile Number

;Copy DS:SI to ES:DI	
	push es
		push ax
			xor ax,ax	
			mov	es,ax			;segment 0 (RAM) is implied	
			mov	di,2000h 		;2bpp tiles
			rol ax,4
			add di,ax
		pop ax
		
	pop es
	ret
FillAreaWithTiles:

