mains segment

UserRam equ 00100h

SmallScreen equ 1
		
CursorX			equ UserRam
CursorY			equ UserRam+1


ProgramStart:		;Needed for header
	cli
	xor		ax,ax
	mov		ss,ax
	mov		sp,0x8000
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	xor ax,ax		;ax=0
	out	00h,ax		;REG_DISP_CTRL - Turn off layers

;Enable Graphics mode + WSC functions	
		  ;BCP0-0--  B=bpp (1=4bpp) C=color (1=WSC)  P=planar (0=yes)
	mov al,11000000b ;DISP_MODE_4BPP + DISP_MODE_COL + DISP_MODE_PLANAR
	out 60h,al 			;REG_DISP_MODE

;Transfer font to pattern ram
	xor ax,ax	
	mov es,ax	 		;segment 0000h (RAM) 
	mov di,4000h 		;RAM_4BPP_TILES_BANK0_BASE
	mov ax,0f000h		;Cartridge segment
	mov ds,ax
	mov si,BitmapFont
	mov cx,BitmapFontEnd-BitmapFont
	
CopyFontAgain:
	mov al,[ds:si]		;Get font line
	mov [es:di],al		;4 bitplanes - all the same!
	inc di	
	mov [es:di],al		;4 bitplanes - all the same!
	inc di
	mov [es:di],al		;4 bitplanes - all the same!
	inc di
	mov [es:di],al		;4 bitplanes - all the same!
	inc di
	inc si				;Next line of font
	Loop CopyFontAgain
	
	
	mov di,0fe00h 		;RAM_4BPP_PALETTE_BASE
	mov ax,0f000h		;Source = ROM
	mov ds,ax
	mov si,WSCpalette	;-RGB one nibble per channel
	mov cx,16
	cld					;Inc mode
	rep movsw			;transfer color palettes	

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

	in al,14h 	;REG_LCD_CTRL	
	or al,1		;LCD_CTRL_LCD_ON (1=High Contrast)
	out 14h,al	;REG_LCD_CTRL
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	
	mov ax, 0F000h	;Cartridge Segment
    mov es, ax
	
	;Address of 255 terminated string in es:ax
	mov si,offset HelloMsg	
	call PrintString
	
	jmp $
	
HelloMsg:
	byte "Hello World",255
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	

PrintString:	;Print 255 terminated strings
	mov al,[es:si]		;Load a letter
	cmp al,255			;CHR=255 ?
	jz PrintString_Done	;Yes? then RET
	call PrintChar		;Print to screen
	inc si				;Next Char
	jmp PrintString		;Repeat
PrintString_Done:
	ret	
	

PrintChar:
	push di
	mov di,1000h
	push es
	push ds
	push ax
		push ax
			xor		ax,ax		;AX=0
			mov		ds,ax		;DS point to RAM
			mov	al,[ds:CursorX]	;Get Xpos
			sal ax,1
			add di,ax
			
			mov	al,[ds:CursorY]	;Get Ypos
			sal ax,6			;32 columns, 2 bytes per column
			add di,ax
		pop ax
		sub al,32				;Char 32 is first in font
;VHBPPPPT TTTTTTT - Tile / Palette / wsc Bank  / Hflip / Vflip
		mov ah,00000000b		;Palette Flip Etc
		mov WORD PTR [ds:di],ax		
		
		inc BYTE PTR [ds:CursorX]
		cmp byte ptr [ds:CursorX],28 ;At end of screen?
		jne PrintCharNoNewLine	;Yes? then Newline
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

	
BitmapFont:	;No Chars below 32 (Space = first)
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

;	Rom Footer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	org 0FFF0h		;65520
	db	0EAh		;JMP (Far)
	dw	ProgramStart;Start of program
	dw	0F000h		;Segment
	db	000h		;Zero
	db	0CDh		;Publisher ID
	db	001h		;Color mode (unused)
	db	001h		;Game ID
	db	000h		;reserved
	db	002h		;Cart Size (4 Mbit)
	db	000h		;SRAM size (None)
	db	004h		;Orientation (1=Vert) / Rom Width (2=8bit) Rom Access speed (4=1 cycle)
	db	000h		;RTC 1=Yes
	dw	00000h		;Checksum
mains ends
