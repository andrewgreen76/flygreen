;Compile With Option: "uasm WSC"

mains segment


UserRam equ 00100h
	
CursorX			equ UserRam
CursorY			equ UserRam+1
PlayerX			equ UserRam+2
PlayerY			equ UserRam+3
EnemyX			equ UserRam+4
EnemyY			equ UserRam+5
EnemyScale			equ UserRam+6
EnemySprite			equ UserRam+7
EnemySpeed			equ UserRam+8
EnemySpeedb			equ UserRam+9
RandomSeed			equ UserRam+10 ;2 byte
BcdHiscore			equ UserRam+12 ;4 byte
BcdScore			equ UserRam+16 ;4 byte
BcdLives			equ UserRam+20 
SoundTimeOut		equ UserRam+21
TotalSprites		equ UserRam+22	

bcdScoreAdd			equ UserRam+23		;5 points in BCD (4 bytes)
	


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
	
	

	
	
;Transfer font to pattern ram
	xor ax,ax	
	mov es,ax	 		;segment 0000h (RAM) 
	ifdef BuildWSC
		mov di,4000h 		;RAM_4BPP_TILES_BANK0_BASE
	else
		mov di,2000h 		;RAM_2BPP_TILES_BANK0_BASE
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
		mov [es:di],al		;4 bitplanes - all the same!
		inc di
		mov [es:di],al		;4 bitplanes - all the same!
		inc di
	endif
	inc si				;Next line of font
	Loop CopyFontAgain
		
	
	
;Transfer the sprites to Paattern Ram
	mov ax,@code			;Segment of ROM (for source data)
	mov ds,ax
	
	mov cx,SpriteBaseEnd-SpriteBase	;Data Length
	mov ax,offset SpriteBase		;Address of source data
	mov SI,ax
	
	mov ax,128				;First DEST tile
	
	;CX=byte Count   DS:SI=source Data   AX= Dest Tile Number
	ifdef BuildWSC
		mov	di,4000h  		;4bpp tiles start 4000h
	else
		mov	di,2000h  		;2bpp tiles start 2000h
	endif
	push es
		push ax
			mov	ax,0000h
			mov	es,ax		;segment 0 (RAM) is implied	
		pop ax
		ifdef BuildWSC
			rol ax,5 		;4 bitplanes * 8 = 32 bytes per tile
		else
			rol ax,4 		;2 bitplanes * 8 = 16 bytes per tile
		endif
		add di,ax
		rep movsb			;Copy CX bytes from DS:SI to ES:DI
	pop es

	


;Sprite Palette
	ifdef BuildWSC
		mov di,0FFE0h 		;First Color sprite palette
		mov si,WSCpalette	;-RGB one nibble per channel
		mov cx,16
		cld					;Inc mode
		rep movsw			;transfer color palettes
	else
		mov ax,0357h		;White on Black background
		out 03Eh,ax			;Palette 15
	endif
	
	
;Sprite Settings
	mov al,7;E00h>>9
	out 04h,al			;SpriteAddr
	
;Window enabled by bit 3 of port 00h
	mov al,0
	out 00Ch,al;  RW  REG_SPR_WIN_X0 MinX
	out 00Dh,al;  RW  REG_SPR_WIN_Y0 MinY
	
	mov al,255
	out 00Eh,al;  RW  REG_SPR_WIN_X1 MaxX
	out 00Fh,al;  RW  REG_SPR_WIN_Y1 MaxY

;Turn on sprites / palette
	 	 ;%--EMWS21 1=Scr 1 2=Scr2 S=Sprite on / W=SprWin on
					; / M=Scr2 Win Mode / E=Scr2 Win Enable
	mov al,00000101b		;DISP_CTRL_SCR1_EN enable SCR1
	out 00h,al				;REG_DISP_CTRL 

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	mov ax,@data 
	mov es,ax
	mov di,offset BcdHiscore	
	xor ax,ax
	STOSW	
	STOSW					;Write 4 zeros to score
	
	
ShowTitle:
	call Cls						;Clear Screen

	mov si,offset txtSuckShoot		;Show Title
	mov bx,0802h	;XXYY
	call LocateAndPrintString

	mov si,offset txtHiscore
	mov bx,0A0Fh	;XXYY
	call LocateandPrintString		;Show Hiscore text
	
	mov ax,@data 
	mov ds,ax
	
	mov bx,0A10h
	call Locate
	mov si,offset BcdHiScore		;Show Hiscore
	mov bl,4						;BCD Bytes
	call BCD_Show					;Show BL bytes of SI
	
	mov byte ptr [EnemyY],72		;Settings for bat sprite
	mov byte ptr [EnemyX],112
	
	mov byte ptr [EnemyScale],48	
	mov byte ptr [EnemySprite],1
	
TitleScreen:	
	xor byte ptr [EnemySprite],1	;Toggle bat frame
	
	mov byte ptr [TotalSprites],0	;Reset sprite count
	call ShowEnemy
	
	mov ax,0FFFFh			;Wait a bit!
	call DoPause
	call DoPause
		
	call ReadJoystick		;Read in the Joystick	%---1UDLR
		
	test al,00010000b		;Compare to Fire1
	jnz TitleScreen			;Repeat until fire pressed

	
	
Gameplay:
	call WaitForRelease		;Wait for Keyup
		
	call cls				;Clear screen
	
	call RandomizeEnemy		;New Enemy Bat position
	
;Zero score
	xor ax,ax
	mov es,ax
	mov di,offset BcdScore	
	STOSW	
	STOSW					;Write 4 zeros to score

;This is a template for +5 points
	xor ax,ax
	mov es,ax
	mov di,offset BcdScoreAdd	
	mov al,5
	STOSB					;Write '5' byte
	xor al,al
	STOSB					;Write 3 zeros to scoreAdd
	STOSB	
	STOSB	
	
	mov byte ptr [BcdLives],4 ;Player lives
	
	mov byte ptr [PlayerX],112	;Player pos
	mov byte ptr [Playery],72
	
	mov byte ptr [EnemySpeed],32 ;Enemy Speed
	
	call UpdateScore		;Show Score/lives text

	
infloop:
	mov al, byte ptr [SoundTimeOut]	;Time till silenced
	dec al
	jnz ChibiSoundUpdated
	call ChibiSound				;Make sound A
ChibiSoundUpdated:
	mov byte ptr [SoundTimeOut],al

	mov byte ptr [TotalSprites],0

	call ReadJoystick		;Read in the Joystick	%---1UDLR
	push ax
		
		mov dh, byte ptr [PlayerX]
		mov dl, byte ptr [PlayerY]
		
		mov ah,4
		test al,00100000b	;Compare to Fire2 (Fast moves!)
		jnz JoyNotF2
		mov ah,8
JoyNotF2:	
		
		test al,00000001b	;Compare to UP
		jnz JoyNotUp
		cmp dl,16			;Check it at the top of the screen
		jc JoyNotUp
		sub dl,ah			;Move Up
JoyNotUp:	

		test al,00000010b	;Compare to Down
		jnz JoyNotDown
		cmp dl,144-16		;Check it at the bottom of the screen
		jnc JoyNotDown
		add dl,ah			;Move Down
JoyNotDown:	

		
		or ah,00000001b
		test al,00000100b	;Compare to Left
		jnz JoyNotLeft
		cmp dh,16			;Check it at the left of the screen
		jc JoyNotLeft
		sub dh,ah			;Move Left
	JoyNotLeft:	

		test al,00001000b	;Compare to Right
		jnz JoyNotRight
		cmp dh,244-16		;Check it at the right of the screen
		jnc JoyNotRight
		add dh,ah			;Move Right
	JoyNotRight:	

		mov byte ptr [PlayerX],dh
		mov byte ptr [PlayerY],dl
		
		call ShowTarget		;Show the new sprite position
		call ShowEnemy		;Show bat
		
		mov ax,0F000h		;Delay
		call DoPause
		
	pop ax					;Read in the Joystick	%---1UDLR
	
	test al,00010000b		;Compare to Fire1
	jne JoyNotF1
	
		mov al,11000001b
		call ChibiSound		;Make sound A
		mov al,2
		mov byte ptr [SoundTimeOut],al
	
		call rangetestPlayer	;1=Collided
		jnc RangeTestDone	;Has player missed?
		
		mov al,11010000b
		call ChibiSound		;Make sound A
		
		inc byte ptr [EnemySpeed]	;Speed up enemy
		
		mov si,bcdScoreAdd		;Source BCD
		mov di,BcdScore			;Dest BCD
		mov bl,4				;BCD Bytes
		call BCD_Add			;ADD BL bytes from SI to DI
		
		call UpdateScore		;Update Score/lives text
		call RandomizeEnemy	;Reposition enemy
RangeTestDone:	
JoyNotF1:		
		
	mov al,byte ptr [EnemySpeedb]
	add al,byte ptr [EnemySpeed] ;Enemy move time
	mov byte ptr [EnemySpeedb],al
	jnc NoEnemyMove				;Don't update enemy this tick
	
	xor byte ptr [EnemySprite],1
	
	mov al,byte ptr [EnemyScale]
	add al,2					;Make enemy bigger
	mov byte ptr [EnemyScale],al
	cmp al,64					;Biggest?
	jc NoEnemyHit
	
		call RandomizeEnemy		;Bat bit us!
		
		mov al,01111000b
		call ChibiSound			;Make sound
		mov al,2
		mov byte ptr [SoundTimeOut],al
		
		dec byte ptr [BcdLives]	;Player lost a life
		jz GameOver				;No lives left?
		
		call UpdateScore		;Update Life count text
NoEnemyHit:	
NoEnemyMove:
	
	jmp infloop			;Repeat 

	
	
	
	
ReadJoystick:		;-SBARLDU
		;  -LLLDDDD
	mov al,00100000b		;X Pad
	out 0b5h,al				;Select
	
	xor ah,ah
	
	in al,0b5h				;Read Xpad
	  	   ;----LDRU
	rcr al,2
	rcl ah,1			;R
	in al,0b5h				;Read Xpad
	rcr al,4
	rcl ah,1			;L
	in al,0b5h				;Read Xpad
	rcr al,3
	rcl ah,1			;D
	in al,0b5h				;Read Xpad
	rcr al,1
	rcl ah,1			;U
		;  -LLLDDDD
	mov al,01000000b		;Buttons
	out 0b5h,al				;Select
	
	in al,0b5h				;Read Buttons
	  	  ;----BAS-
	test al,00000010b		;Mask Direction bits
	jz ReadJoystick_NoStart
	or ah,01000000b
ReadJoystick_NoStart:
	  	  ;----BAS-
	and al,00001100b		;Mask Direction bits
	rol al,2
	or al,ah
	xor al,11111111b
	ret
	

WaitForRelease:
	call ReadJoystick		;Read in the Joystick	%---1UDLR
	test al,00010000b		;Compare to Fire1
	jz WaitForRelease
	ret
	
	

GameOver:
	call WaitForRelease		;Wait for Keyup
	
	mov al,0
	call ChibiSound			;Silence sound

	call cls				;Clear Screen
	
	mov bx,0907h			;XXYY
	mov si,offset txtGameOver ;Show GameOver
	call LocateAndPrintString
	
	mov si,BcdScore			;Source BCD
	mov di,BcdHiscore		;Dest BCD
	mov bl,4				;BCD Bytes
	call BCD_Cp				;CMP SI,DI (BL Bytes)	
	
	jc GameOver_NoScore		;New score lower

	xor ax,ax			;Update Highscore
	mov es,ax
	mov di,offset BcdHiscore	
	MOVSW
	MOVSW
	
GameOver_HiScore:			;We got a highscore!
	mov bx,0809h			;XXYY
	mov si,offset txtGotHiScore ;Show Highscore Message
	call LocateAndPrintString
	
GameOver_Wait:
	call ReadJoystick		;Read in the Joystick	%---1UDLR
	test al,00010000b		;Fire1 Pressed?
	jnz GameOver_Wait
	jmp ShowTitle
	
GameOver_NoScore:			;No highscore, we officially suck!
	mov bx,0909h			;XXYY
	mov si,offset txtNoHiScore	;Show Suck Message
	call LocateAndPrintString
	jmp GameOver_Wait	

txtGameOver:
	db "GAME OVER",255
txtGotHiScore:	
	db "NEW HISCORE",255
txtNoHiScore:				;Test string (Ucase only)
	db "YOU SUCK!",255	

	

DoPause:
	dec ax
	jne DoPause	
	ret	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

txtSuckShoot:
	db "SUCK SHOOT!",255
txtHiscore:
	db "HISCORE:",255

Cls:
;Clear the tilemap
	push es
		xor ax,ax		
		mov es,ax		;segment 0 (RAM) 
		mov di,1000h	;SCR1 Tilemap
		mov ax,0		;Tile 0 (VHBPPPPT TTTTTTT)
		mov cx,32*32 	;MAP_WIDTH_CH*MAP_HEIGHT_CH
		cld			
		rep stosw
	pop es
;No sprites
	mov al,0
	out 06h,al			;Sprite count
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
	pop ax
	pop ds
	pop es
	pop di
	ret

	

Locate:
	push ds
		mov ax, 0000h
		mov ds, ax	
		mov byte ptr [ds:CursorX],bh
		mov byte ptr [ds:CursorY],bl
	pop ds
	ret
	

LocateandPrintString:
	call Locate	
PrintString:	;Print 255 terminated string from [ds:si]
	mov al,[cs:si]		;Load a letter
	cmp al,255			;CHR=255 ?
	jz PrintString_Done	;Yes? then RET
	call PrintChar		;Print to screen
	inc si				;Next Char
	jmp PrintString		;Repeat
PrintString_Done:
	ret		
	
	
	
	

ShowEnemy:
	xor ax,ax

	mov al, byte ptr [EnemyScale]	;Scale *8
	xor al,255
	shr al,1
	and al,00011000b
	
	mov bl, byte ptr [EnemySprite]
	and bl,00000001h				;Frame *4
	shl bl,1
	shl bl,1
	add al,bl
	add al,4						;First Bat Sprite=+4 bytes
	
	mov si,offset SpriteInfo
	add si,ax						;Pos in SpriteInfo Table
	
	mov dh, byte ptr [EnemyX]		;XYpos of bat
	mov dl, byte ptr [EnemyY]
	jmp ShowSprite
	
	
ShowTarget:
	mov dh, byte ptr [PlayerX]		;XYPos of player
	mov dl, byte ptr [PlayerY]
	mov si,offset SpriteInfo		;First sprite in SpriteInfo Table
	
	
;XOR sprite at (X,Y) pos (DH,DL)
ShowSprite:		
	call GetSpritePointerDI	;Get the Ram address of 
	push ds							;the current sprite
		mov ax, @code		;Point DS to this segment
		mov ds, ax
		
		mov al,[cs:si+2]	;Width
		shr al,1			;/2
		sub dh,al			;Center X
		
		mov al,[cs:si+3]	;Height
		shr al,1			;/2
		sub dl,al			;Center Y

		xor ax,ax
		mov es,ax			;ES=0000h
	
		mov ch,[cs:si+2]	;Width in sprites
		shr ch,3
		
		mov cl,[cs:si+3]	;Height in sprites
		shr cl,3
		
		mov si,[cs:si+0]	;Sprite Table pointer
		
SpriteNextY:		
		push cx
		push dx
SpriteNextX:	
			xor ax,ax
			mov al,[cs:si]		;Get Tile Number
			cmp al,0
			jz SpriteUnneeded 	;Skip Zero Tiles
			add ax,0E80h		
				;  nnnnnnnn		n - Tile number
			mov [es:di],al
			inc di
				;  VHPWpppn		;V=Vflip H=Hflip P=Priority 
			mov [es:di],ah			;W=Window p=palette
			inc di					;Palette (8+)
			
			mov [es:di],dl	;Ypos
			inc di
			mov [es:di],dh	;Xpos
			inc di
			
			inc bl			;SpriteCount
	SpriteUnneeded:		
			inc si
			add dh,8		;Move across 8 pixels
			
			dec ch
			jne SpriteNextX	;X Loop
		pop dx
		pop cx
		add dl,8			;Move down 8 pixels
		
		dec cl
		jne SpriteNextY		;Y Loop
		
		mov al,0
		out 05h,al			;FirstSprite to draw
		mov al,bl
		out 06h,al			;Drawn Sprite Count
	pop ds
	mov byte ptr [TotalSprites],bl
	ret		

GetSpritePointerDI:
	xor bx,bx
	mov bl,byte ptr [TotalSprites]	;Current Free Hsprite Num
	mov di,bx
	rol di,2						;SpriteNum *4
	add di,0E00h					;Sprite Base
	ret	

UpdateScore:
	mov bx,0000h		;XXYY
	call Locate
	
	mov bl,4			;4 Bytes
	mov si,BcdScore	;Show Score
	call BCD_Show	
	
	mov bx,1A00h		;XXYY
	call Locate
	
	mov bl,1			;1 Byte
	mov si,BcdLives	;Show Lives
	jmp BCD_Show	
		
	
rangetestPlayer:
	mov ch,byte ptr [PlayerX]
	mov cl,byte ptr [PlayerY]
	
	mov bh,byte ptr [EnemyX]
	mov bl,byte ptr [EnemyY]
	
	
	mov dh,4			;Width
	mov dl,12			;Height
	jmp rangetest
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
;See if object XY pos zD,zE hits object zB,zC in range zH,zL
;Return A=1 Collision... A!=1 means no collision

rangetest:			
	mov al,bh			;Pos1 Xpos
	sub al,dh			;Shift Pos1 by 'range' to the Left
	jc rangetestb
	cmp al,ch			;Does it match Pos2?
	jnc rangetestoutofrange
rangetestb:
	add al,dh			;Shift Pos1 by 'range' to the Right
	add al,dh
	jc rangetestd		;>255
	cmp al,ch			;Does it match Pos2?
	jc rangetestoutofrange
	
rangetestd:				;Y Axis Check
	mov al,bl			;Pos1 Ypos
	sub al,dl			;Shift Pos1 by 'range' Up
	jc rangetestc		;<0
	cmp al,cl			;Does it match Pos2?
	jnc rangetestoutofrange
rangetestc:
	add al,dl			;Shift Pos1 by 'range' Down
	add al,dl
	jc rangeteste		;>255
	cmp al,cl			;Does it match Pos2?
	jc rangetestoutofrange			
rangeteste:
	stc					;C  = Collided
	ret
rangetestoutofrange:		
	clc					;NC = No Collision
	ret
	
RandomizeEnemy:
	mov bh,16
	mov bl,244-16
	call dorangedrandom	
	mov byte ptr [EnemyX],al
	
	mov bh,16
	mov bl,144-16
	call dorangedrandom	
	mov byte ptr [EnemyY],al
	
	mov byte ptr [EnemyScale],16		;Default Enemy scale
		
	ret		
		
	
PixelsPerByte equ 1	
	
	

	
SpriteBase:				;Bitmap data - 2/4 Bitplanes
	ifdef BuildWSC
		incbin "\ResALL\SuckShoot\SuckShootWSC.raw"
	else
		incbin "\ResALL\SuckShoot\SuckShootWSW.raw"
	endif
SpriteBaseEnd:
	
SpriteInfo:	
    dw Sprite_1                 ;SpriteAddr 1
     db 16,16                   	;XY 
    dw Sprite_2                 ;SpriteAddr 2
     db 32,24                       ;XY 
    dw Sprite_3                  ;SpriteAddr 3
     db 32,32                       ;XY 
    dw Sprite_4                  ;SpriteAddr 4
     db 24,16                       ;XY 
    dw Sprite_5                  ;SpriteAddr 5
     db 24,24                       ;XY 
    dw Sprite_6                  ;SpriteAddr 6
     db 16,8                        ;XY 
    dw Sprite_7                  ;SpriteAddr 7
     db 16,16                       ;XY 

	 
Sprite_1:						;Sprite Tilemap 1
  db 1,2					
  db 3,4

Sprite_2:						;Sprite Tilemap 2
  db 5,6,7,8
  db 9,10,11,12
  db 0,13,14,0

Sprite_3:						;Sprite Tilemap 3
  db 15,16,17,18
  db 19,20,21,22
  db 23,24,25,26
  db 27,28,29,30

Sprite_4:						;Sprite Tilemap 4
  db 31,32,33
  db 0,34,0

Sprite_5:
  db 35,36,37
  db 38,39,40
  db 41,42,43

Sprite_6:
  db 44,45

Sprite_7:
  db 46,47
  db 48,49


	
	
;Random number Lookup tables
Randoms1:
	db 0Ah,9Fh,0F0h,1Bh,69h,3Dh,0E8h,52h,0C6h,41h,0B7h,74h,23h,0ACh,8Eh,0D5h
Randoms2:
	db 9Ch,0EEh,0B5h,0CAh,0AFh,0F0h,0DBh,69h,3Dh,58h,22h,06h,41h,17h,74h,83h
	


BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:
	
	include \SrcALL\V1_Random.asm
	include \SrcALL\V1_BCD.asm
	

	ifdef BuildWSC		;Palette
WSCpalette:		
		dw 0000h ;0  -RGB
		dw 000Ah ;1  -RGB
		dw 01A0h ;2  -RGB
		dw 00AAh ;3  -RGB
		dw 0A00h ;4  -RGB
		dw 0A0Ah ;5  -RGB
		dw 0A50h ;6  -RGB
		dw 0AAAh ;7  -RGB
		dw 0555h ;8  -RGB
		dw 055Fh ;9  -RGB
		dw 05F5h ;10  -RGB
		dw 05FFh ;11  -RGB
		dw 0F55h ;12  -RGB
		dw 0F5Fh ;13  -RGB
		dw 0FF5h ;14  -RGB
		dw 0FFFh ;15  -RGB
	endif
	
	include \SrcWSW\V1_ChibiSound.asm	
	

	
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
