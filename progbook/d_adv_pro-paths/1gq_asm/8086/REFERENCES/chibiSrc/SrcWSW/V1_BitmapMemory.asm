
ScreenInit:
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
		mov di,2000h 	;RAM_2BPP_TILES_BANK0_BASE
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
	ret

	;mov al,0		;LCD_ICON_SLEEP	
	;out 15h,al		;REG_LCD_ICON


;CX=byte Count   DS:SI=source Data   AX= Dest Tile Number
DefineTiles:
	ifdef BuildWSC
		mov	di,4000h  ;4bpp tiles start 4000h
	else
		mov	di,2000h  ;2bpp tiles start 2000h
	endif
	push es
		push ax
			mov	ax,0000h
			mov	es,ax	;segment 0 (RAM) is implied	
		pop ax
		ifdef BuildWSC
			rol ax,5 ;4 bitplanes * 8 = 32 bytes per tile
		else
			rol ax,4 ;2 bitplanes * 8 = 16 bytes per tile
		endif
		add di,ax
		rep movsb	;Copy CX bytes from DS:SI to ES:DI	
	pop es
	ret

	
	

;	mov bh,6	;X
;	mov bl,6	;Y
	
;	mov ch,6	;W
;	mov cl,6	;H
	
;	mov ax,128	;First Tile
;	call FillAreaWithTiles
	
	
;Tile address=
;Base + (Ypos * 32 * 2) + (Xpos * 2)	
	
;Start XY=(BH,BL)... Width/Height WH =(CH,CL)... First tile AX

FillAreaWithTiles:
	push es
FillAreaWithTiles_Yagain:	
		push bx
		push cx
			push ax
				xor ax,ax
				mov es,ax	;ES=0000h
				
				mov di,1000h;Tilemap 1 base
				mov	al,bh	;BH=X pos - AH=0
				sal ax,1	;2 bytes per tile
				
				add di,ax	
				
				xor ax,ax
				mov	al,bl	;BY=Ypos
				sal ax,6	;32 columns, 2 bytes per column
				add di,ax
			pop ax
FillAreaWithTiles_Xagain: 
;VHBPPPPT TTTTTTT - Tile / Palette / wsc Bank  / Hflip / Vflip
			mov WORD PTR [es:di],ax	;VHBPPPPT TTTTTTT
			inc di		
			inc di
			inc ax			;Tile Num
			dec ch			;Width
			jne FillAreaWithTiles_Xagain
		pop cx
		pop bx
		inc bl
		dec cl				;Height
		jne FillAreaWithTiles_Yagain
	pop es
	ret
	
SetPalette:						;AX = color, DX= -GRB
	ifdef BuildWSC
		push dx
		push es
		push di
			push ax				;swap -GRB to -RGB
				mov al,dh		;----GGGG
				and ah,00001111b 	
				shl al,4		;GGGG----
				
				mov ah,dl		;RRRR----
				shr ah,4
				and ah,00001111b;----RRRR
				mov dh,ah
				
				mov ah,dl
				and ah,00001111b;----BBBB
				or ah,al		;GGGGBBBB
				mov dl,ah
			
				xor ax,ax	
				mov es,ax	 	;segment 0000 (RAM) 
				mov di,0fe00h 	;RAM_4BPP_PALETTE_BASE
			pop ax
			push ax
				sal ax,1		;2 bytes per color
				add di,ax
				mov [es:di],dx
			pop ax
		pop di
		pop es
		pop dx
	endif
	ret



	
	
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

Locate:
	mov BYTE PTR [ds:CursorX],bh
	mov BYTE PTR [ds:CursorY],bl
	ret
NewLine:
	mov BYTE PTR [ds:CursorX],0
	inc BYTE PTR [ds:CursorY]
	ret
	
PrintSpace:
	push ax
		mov al,' '
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
