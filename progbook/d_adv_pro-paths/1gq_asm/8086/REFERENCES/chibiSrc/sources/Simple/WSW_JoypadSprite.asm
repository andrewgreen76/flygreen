
mains segment

@data 	equ 00000h
@code 	equ 0F000h

ProgramStart:				;Needed for footer
	cli
	xor		ax,ax
	mov		ss,ax
	mov		sp,0x8000		;Define a stack pointer
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
	xor ax,ax				;ax=0
	out	00h,ax				;REG_DISP_CTRL - Turn off layers

	
;Enable Graphics mode + WSC functions	
	ifdef BuildWSC
			  ;BCP0-0--  B=bpp (1=4bpp) C=color (1=WSC)  P=planar (0=yes)
		mov al,11000000b 	;DISP_MODE_4BPP + DISP_MODE_COL + DISP_MODE_PLANAR
	else
			  ;BCP0-0--  B=bpp (1=4bpp) C=color (1=WSC)  P=planar (0=yes)
		mov al,00000000b 	;DISP_MODE_PLANAR	
	endif
	out 60h,al 				;REG_DISP_MODE

	xor ax,ax				; reset scrolling
	out 10h,ax				;REG_SCR1_X
	out 11h,ax				;REG_SCR1_Y

		;  21
	mov al,32h				;Screen Base   WS:%-222-111 SCR2, SCR1 
	out 07h,al				;REG_MAP_BASE WSC:%22221111 SCR2, SCR1 

	ifdef BuildWSC
		in al,14h 			;REG_LCD_CTRL	
		or al,1				;LCD_CTRL_LCD_ON (1=High Contrast)
		out 14h,al			;REG_LCD_CTRL
	endif	
	
	
	
;Set up palette	
	ifdef BuildWSC			;Copy palette to vram
		xor ax,ax	
		mov es,ax	 		;segment 0 (RAM) is implied	


		mov ax,0f000h		;Source = ROM
		mov ds,ax
		
		mov di,0fe00h 		;RAM_4BPP_PALETTE_BASE
		mov si,WSCpalette	;-RGB one nibble per channel
		mov cx,16
		cld					;Inc mode
		rep movsw			;transfer color palettes	
		
		
	else
		;Black and white palette
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
	
	
;Clear the tilemap
	xor ax,ax		
	mov es,ax		;segment 0 (RAM) 
	mov di,1000h	;SCR1 Tilemap
	mov ax,0		;Tile 0 (VHBPPPPT TTTTTTT)
	mov cx,32*32 	;MAP_WIDTH_CH*MAP_HEIGHT_CH
	cld			
	rep stosw

	
;Transfer the sprites to Tile Ram
	mov ax,@code			;Segment of ROM (for source data)
	mov ds,ax
	
	mov cx,BitmapTestEnd-BitmapTest	;Data Length
	mov ax,offset BitmapTest		;Address of source data
	mov SI,ax
	
	mov ax,128						;First DEST tile

	
;CX=byte Count   DS:SI=source Data   AX= Dest Tile Number
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

	


;Sprite Palette... Sprite palette 0-7 are palette defs 8-15
	ifdef BuildWSC
		mov di,0fF00h 		;First Color sprite palette
		mov si,WSCpalette	;-RGB one nibble per channel
		mov cx,16
		cld					;Inc mode
		rep movsw			;transfer color palettes
	else
		mov ax,0357h		;White on Black background
		out 030h,ax			;Palette 8 - REG_PALMONO_0 HL
	endif

;Window enabled by bit 3 of port 00h
	mov al,0
	out 00Ch,al		;  RW  REG_SPR_WIN_X0 MinX
	out 00Dh,al		;  RW  REG_SPR_WIN_Y0 MinY
	
	mov al,80
	out 00Eh,al		;  RW  REG_SPR_WIN_X1 MaxX
	out 00Fh,al		;  RW  REG_SPR_WIN_Y1 MaxY

;Sprite Settings
	mov al,7		;E00h>>9
	out 04h,al		;SpriteAddr
	
;Turn on sprites 
	 	 ;%--EMWS21 1=Scr 1 2=Scr2 S=Sprite on / W=SprWin on / 
			;M=Scr2 Win Mode / E=Scr2 Win Enable
	mov al,00001101b		;DISP_CTRL_SCR1_EN enable SCR1
	out 00h,al				;REG_DISP_CTRL 
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	
    mov ax, @data
	mov ds, ax
	
	mov ax, @code
    mov es, ax
	
			
	mov dh,6		;Xpos
	mov dl,6		;Ypos
		
	call ShowSprite		;Show the starting position
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	
infloop:
		;  -LLLDDDD
	mov al,00100000b	;X Pad
	out 0b5h,al			;Select
	in al,0b5h			;Read Xpad
	  	   ;----LDRU
	and ax,00001111b	;Mask Direction bits
	jz infloop

	
	test al,00000001b	
	jz CurNotUp
	cmp dl,-8			;Check it at the top of the screen
	jz CurNotUp
	dec dl				;Move Up
CurNotUp:	

	test al,00000100b	;Compare to Down
	jz CurNotDown
	cmp dl,144			;Check it at the bottom of the screen
	jz CurNotDown
	inc dl				;Move Down
CurNotDown:	

	test al,00001000b	;Compare to Left
	jz CurNotLeft
	cmp dh,-8			;Check it at the left of the screen
	jz CurNotLeft
	dec dh				;Move Left
CurNotLeft:	

	test al,00000010b	;Compare to Right
	jz CurNotRight
	cmp dh,224			;Check it at the right of the screen
	jz CurNotRight
	inc dh				;Move Right
CurNotRight:	

	call ShowSprite		;Show the new sprite position
	
	mov cx,02000h		;pause
delay:
	loop delay
	
	jmp infloop			;Repeat 


;Sprite routines
	
ShowSprite:
	mov al,0
	out 05h,al			;FirstSprite to draw
	mov al,1
	out 06h,al			;LastSprite to draw
	
	xor ax,ax	
	mov es,ax			;ES=0000h (RAM)
	
		;  NNNNNNNN		;N=tile Number
	mov [es:0E00h],128
	
		; VHPWpppN	 V=Vflip H=Hflip P=Priority W=Window (0=inside 1=out)
	mov [es:0E01h],00000000b	;p=Palette (Sprites use pal 8+ out 30h+)
	
	mov [es:0E02h],dl	;Ypos
	
	mov [es:0E03h],dh	;Xpos
	ret		
	
	

	
BitmapTest:			;Sprite Data - Bitplanes 4bpp / 2 bpp
	ifdef BuildWSC
        DB 0x3C,0x00,0x00,0x00     ;  0
        DB 0x7E,0x00,0x00,0x00     ;  1
        DB 0xFF,0x24,0x00,0x00     ;  2
        DB 0xFF,0x00,0x00,0x00     ;  3
        DB 0xFF,0x00,0x00,0x00     ;  4
        DB 0xDB,0x24,0x00,0x00     ;  5
        DB 0x66,0x18,0x00,0x00     ;  6
        DB 0x3C,0x00,0x00,0x00     ;  7
	else
		DB 0x3C,0x00     ;  0
        DB 0x7E,0x00     ;  1
        DB 0xFF,0x24     ;  2
        DB 0xFF,0x00     ;  3
        DB 0xFF,0x00     ;  4
        DB 0xDB,0x24     ;  5
        DB 0x66,0x18     ;  6
        DB 0x3C,0x00     ;  7
	endif
	
	
	incbin "\resALL\Font96.FNT"
BitmapTestEnd:	
	
	


	ifdef BuildWSC		;Palette
WSCpalette:		
		;  	 -RGB
		dw 0x0008	;0
		dw 0x0FF0	;1
		dw 0x00FF	;2
		dw 0x0F00	;3
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
