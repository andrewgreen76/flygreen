;UseADLIB equ 1 			;Use ADLIB for sound (else beeper)

;Text after semicolon is comments, you don't need to type it in
	
    .model small		;Tell Assembler Memory Model to use
    .stack 1024			;Stack pointer area
	
    .data

	.code				;Code Segment (CS)
	

	mov ah, 0 	;0=Set Video mode (AL=Mode)
    mov al, 4   ;Mode 4 (cga 320x200 4 color)
    int 10h     ;Bios int
	
	mov ah, 0Bh ;B= Set color palette
	mov bh, 1   ;1 = 4 palette mode
	mov bl, 1   ;0 = warm colors (R,G,Y) 1 = cool (C,M,W)
	int 10h    	;Bios int

	mov ah, 0Bh	;B= Set color palette 
	mov bh, 0   ;0 = Brightness
	mov bl, 10h ;High intensity
	;mov bl, 0	;Low intensity
	int 10h


	mov ax, seg CursorY
	mov ds, ax	
	
	

ShowTitle:
	call Cls						;Clear Screen

	
	
	mov si,offset txtSuckShoot		;Show Title
	mov bx,0F04h	;XXYY
	call LocateAndPrintString

	mov si,offset txtHiscore
	mov bx,1012h
	call LocateandPrintString		;Show Hiscore text
	
	mov bx,1013h
	call Locate
	mov si,offset BcdHiScore		;Show Hiscore
	mov bl,4						;BCD Bytes
	call BCD_Show					;Show BL bytes of SI
	
	mov byte ptr [EnemyY],88		;Settings for bat sprite
	mov byte ptr [EnemyX],80
	
	mov byte ptr [EnemyScale],48	
	mov byte ptr [EnemySprite],1
	
	
TitleScreen:	
	xor byte ptr [EnemySprite],1	;Toggle bat frame

	call ShowEnemy

	mov ax,0FFFFh					;Wait a bit!
	call DoPause
	call DoPause
	call DoPause
	call DoPause
	
	call ShowEnemy
	
	call ReadJoystick		;Read in the Joystick	%---1UDLR
		
	test al,00010000b		;Compare to Fire1
	jnz TitleScreen			;Repeat until fire pressed
	
	
	
Gameplay:
	call cls				;Clear screen
	
	call RandomizeEnemy		;New Enemy Bat position
	
	mov byte ptr [BcdLives],4 ;Player lives
	
	mov ax,seg BcdScore
	mov es,ax
	mov di,offset BcdScore	
	xor ax,ax
	STOSW	
	STOSW					;Write 4 zeros to score
	
	mov byte ptr [PlayerX],80	;Player pos
	mov byte ptr [Playery],96
	
	mov byte ptr [EnemySpeed],32 ;Enemy Speed
	
	call UpdateScore		;Show Score/lives text

	
infloop:
	mov al, byte ptr [SoundTimeOut]	;Time till silenced
	dec al
	jnz ChibiSoundUpdated
	call ChibiSound				;Make sound A
ChibiSoundUpdated:
	mov byte ptr [SoundTimeOut],al



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
		cmp dl,200-12		;Check it at the bottom of the screen
		jnc JoyNotDown
		add dl,ah			;Move Down
JoyNotDown:	

		shr ah,1			;Double move speed for LR moves
		
		or ah,00000001b
		test al,00000100b	;Compare to Left
		jnz JoyNotLeft
		cmp dh,8			;Check it at the left of the screen
		jc JoyNotLeft
		sub dh,ah			;Move Left
	JoyNotLeft:	

		test al,00001000b	;Compare to Right
		jnz JoyNotRight
		cmp dh,160-8		;Check it at the right of the screen
		jnc JoyNotRight
		add dh,ah			;Move Right
	JoyNotRight:	

		mov byte ptr [PlayerX],dh
		mov byte ptr [PlayerY],dl
		
		
		
		call ShowEnemy		;Show bat
		call ShowTarget		;Show the new sprite position
		
		mov ax,0F000h		;Delay
		call DoPause

		call ShowEnemy		;Remove old sprites
		call ShowTarget	

		
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
		
		call RandomizeEnemy	;Reposition enemy
				
		mov si,bcdScoreAdd		;Source BCD
		mov di,BcdScore			;Dest BCD
		mov bl,4				;BCD Bytes
		call BCD_Add			;ADD BL bytes from SI to DI
		
		call UpdateScore		;Update Score/lives text
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
		call ChibiSound			;Silence sound
		mov al,2
		mov byte ptr [SoundTimeOut],al
		
		dec byte ptr [BcdLives]	;Player lost a life
		jz GameOver				;No lives left?
		
		call UpdateScore		;Update Life count text
NoEnemyHit:	
NoEnemyMove:
	
	jmp infloop			;Repeat 

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
GameOver:
	call WaitForRelease		;Wait for Keyup
	
	mov al,0
	call ChibiSound			;Silence sound

	call cls				;Clear Screen
	
	mov bx,0F08h			;XXYY
	mov si,offset txtGameOver ;Show GameOver
	call LocateAndPrintString
	
	mov si,BcdScore			;Source BCD
	mov di,BcdHiscore		;Dest BCD
	mov bl,4				;BCD Bytes
	call BCD_Cp				;CMP SI,DI (BL Bytes)	
	
	jc GameOver_NoScore		;New score lower

	mov ax,seg BcdScore		;Update Highscore
	mov es,ax
	mov di,offset BcdHiscore	
	MOVSW
	MOVSW
	
GameOver_HiScore:			;We got a highscore!
	mov bx,0E0Ch			;XXYY
	mov si,offset txtGotHiScore ;Show Highscore Message
	call LocateAndPrintString
	
GameOver_Wait:
	call ReadJoystick		;Read in the Joystick	%---1UDLR
	test al,00010000b		;Fire1 Pressed?
	jnz GameOver_Wait
	jmp ShowTitle
	
GameOver_NoScore:			;No highscore, we officially suck!
	mov bx,0F0Ch			;XXYY
	mov si,offset txtNoHiScore	;Show Suck Message
	call LocateAndPrintString
	jmp GameOver_Wait	

txtGameOver:
	db "GAME OVER",255
txtGotHiScore:	
	db "NEW HISCORE",255
txtNoHiScore:				;Test string (Ucase only)
	db "YOU SUCK!",255	

	
	
	
	
WaitForRelease:
	call ReadJoystick		;Read in the Joystick	%---1UDLR
	test al,00010000b		;Compare to Fire1
	jz WaitForRelease
	ret


UpdateScore:
	mov bx,0000h		;XXYY
	call Locate
	
	mov bl,4			;4 Bytes
	mov si,BcdScore	;Show Score
	call BCD_Show	
	
	mov bx,2500h		;XXYY
	call Locate
	
	mov bl,1			;1 Byte
	mov si,BcdLives	;Show Lives
	jmp BCD_Show	
		
	

DoPause:
	dec ax
	jne DoPause	
	ret
	
txtSuckShoot:
	db "SUCK SHOOT!",255
txtHiscore:
	db "HISCORE:",255


	
LocateandPrintString:
	call Locate	
PrintString:	;Print 255 terminated string from [ds:si]
	mov al,[ds:si]		;Load a letter
	cmp al,255			;CHR=255 ?
	jz PrintString_Done	;Yes? then RET
	call PrintChar		;Print to screen
	inc si				;Next Char
	jmp PrintString		;Repeat
PrintString_Done:
	ret		
	
cls:
	mov cx,04000h		;Byte count (320*200/4)
	mov ax,0B800h		
	mov es,ax			;Vram segment B800
	xor ax,ax
	mov di,ax
	mov ax,0			;0
	rep STOSB			;Fill Zeros
	ret	
	
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
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	
	
RandomizeEnemy:
	push ds
	    mov ax, @code
		mov ds, ax
	
		mov bh,16
		mov bl,160-16
		call dorangedrandom	
		mov byte ptr [EnemyX],al
		
		mov bh,16
		mov bl,200-16
		call dorangedrandom	
		mov byte ptr [EnemyY],al
		
		mov byte ptr [EnemyScale],16		;Default Enemy scale
		
	pop ds
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
;Calculate Screen pos
	mov ax,0B800h 		;Screen base 
	mov es,ax
	mov ax, @code		;Point DS to this segment
	mov ds, ax
	
	push dx	
		xor ax,ax
		mov al,dh			;AL=Xpos
		mov cl,[ds:si+2]	;Width
		shr cl,1			;/2
		shr cl,1			;Logical units (2px = 1 lu)
		sub al,cl			;Center X
		shr ax,1			;/2	(To pixels)
		mov di,ax
		
		xor ax,ax
		mov al,dl			;AL=Ypos
		mov cl,[ds:si+3]	;Height
		shr cl,1			;/2
		sub al,cl			;Center Y
		and al,11111110b	;Pairs of lines
		
		test dl,00000001b	;Interlacing
		jz GetScreenPos_OddLine
		xor di,2000h		;Alternate lines at offset 2000h
GetScreenPos_OddLine:		

		mov bx,80/2			;80 bytes per 2 lines (Ypos * 40)
		mul bx				;as lines are interlaced
		add di,ax
	pop dx					;ES:DI is VRAM Destination
	
	
;Draw XOR sprite SI
	
	mov cl,[ds:si+3]		;Height
	mov bl,[ds:si+2]		;Width
	mov si,[ds:si+0] ;DS:SI=Source bitmap
	shr bl,1
	shr bl,1
DrawBitmap_Yagain:
	push di
		mov ch,bl		;Width
DrawBitmap_Xagain:				
		mov al,[DS:SI]
		xor al,[ES:DI]	;Xor with current screen data.
		mov [ES:DI],al
		inc si
		inc di
		dec ch
		jnz DrawBitmap_Xagain ; Next horizontal pixel
	pop di
	
	mov ax,di
	and ax,2000h	;See if we're doing interlaced part
	mov ax,di
	jz GetScreenNextLineDone
	add ax,80		;80 bytes per line (40*2)
GetScreenNextLineDone:	
	xor ax,2000h	;Alternate lines at offset 2000h
	mov di,ax
	
	dec cl
	jnz DrawBitmap_Yagain
	ret		

PlayerX: 
	db 80
PlayerY: 
	db 100
	
EnemyX:
	db 32
EnemyY:
	db 32	
EnemyScale:
	db 32	
EnemySprite:
	db 1


EnemySpeed: 
	db 0
EnemySpeedb: 
	db 0


RandomSeed dw 0		;2 bytes


PrintChar:
	push si
	push di
	push es
	push ds
	push dx
	push cx
	push bx
	push ax
		mov bx, seg CursorY
		mov ds, bx	
		push ds
			push ax
				mov ax,0
				mov al,byte ptr [ds:CursorY]
				mov bx,40*4*2		;40 bytes per line - 4 lines per char - 2 bytes per line
				mul bx					;(other 4 lines at different address)
				mov di,ax
				mov ax,0
				mov al,byte ptr [ds:CursorX]	
				rcl ax,1			;2 Bytes per char
				add di,ax
			
				mov si,offset BitmapFont ;Get Font address
				mov ax, seg BitmapFont
				mov ds, ax			;DS:SI=Data source
			pop ax
			sub al,32				;No char below 32
			mov ah,0
			mov cl,3				;8 bytes per char
			rcl ax,cl				;AX * 8
			add si,ax
			mov cx,4				;4 pairs of lines
			push es
				mov ax,0B800h 		;Screen base Segment 
				mov es,ax
FontAgain:		push cx
					Call PrintCharDoPair
					add di,2000h	;Alternate lines interlaced at BA00h
					Call PrintCharDoPair
					sub di,2000h	;Back to B800h
					add di,80
				pop cx
				dec cx
				jnz FontAgain
			pop es
		pop ds
		inc byte ptr [ds:CursorX]
		cmp byte ptr [ds:CursorX],40 ;Are we at the end of the screen
		jne PrintCharNoNewLine
		call NewLine			;Move down a line
PrintCharNoNewLine:
	pop ax
	pop bx
	pop cx
	pop dx
	pop ds
	pop es
	pop di
	pop si
	ret

	
PrintCharDoPair:		;Do one line of our font
	mov al,[ds:si]
	mov cl,2			;For RCL
	Call PrintCharDoOne	;First Half
	inc di				;Move Dest Right
	Call PrintCharDoOne ;2nd Half
	inc si				;Increasae Source (font)
	dec di				;Move Dest Left
	ret

PrintCharDoOne:	;2 bits per pixel
	mov ah,0
	rcl al,1
	rcl ah,cl	;Shift Left 2
	rcl al,1
	rcl ah,cl	;Shift Left 2
	rcl al,1
	rcl ah,cl	;Shift Left 2
	rcl al,1
	rcl ah,1
	mov bh,ah	;Back up
	rcl ah,1	
	or ah,bh	;OR (set both bits to 1)
	mov es:[di],ah	;Store result
	ret
	
NewLine:
	push ds
	push ax
		mov ax, seg CursorY
		mov ds, ax	
		mov byte ptr [ds:CursorX],0	;Reset Xpos
		inc byte ptr [ds:CursorY]	;Move down a line
	pop ax
	pop ds
	ret

Locate:
	push ds
		mov ax, seg CursorY
		mov ds, ax	
		mov byte ptr [ds:CursorX],bh
		mov byte ptr [ds:CursorY],bl
	pop ds
	ret
	
	
	
CursorX:
	db 0
CursorY:
	db 0

	
;Random number Lookup tables
Randoms1:
	db 0Ah,9Fh,0F0h,1Bh,69h,3Dh,0E8h,52h,0C6h,41h,0B7h,74h,23h,0ACh,8Eh,0D5h
Randoms2:
	db 9Ch,0EEh,0B5h,0CAh,0AFh,0F0h,0DBh,69h,3Dh,58h,22h,06h,41h,17h,74h,83h
	


BitmapFont:
	incbin "\resALL\Font96.FNT"
	
	include \SrcALL\V1_Random.asm
	include \SrcALL\V1_BCD.asm
	
	include \SrcDOS\V1_ReadJoystick.asm
	
	
	ifdef UseADLIB
		include \SrcDOS\V1_ChibiSoundAdlib.asm
	else
		include \SrcDOS\V1_ChibiSound.asm
	endif
	
	
	
	
	



bcdScoreAdd:	;5 points in BCD
	db 5,0,0,0
	
BcdHiscore: 
	db 0,0,0,0
BcdScore: 
	db 0,0,0,0
BcdLives: 
	db 0
SoundTimeOut: 
	db 0

PixelsPerByte equ 4
	
SpriteBase:									;Bitmap data
	incbin "\ResALL\SuckShoot\SuckShootDOSCGA.raw"
	
SpriteInfo:	
    dw 0000h/PixelsPerByte + SpriteBase     ;SpriteAddr 0 -Cursor
     db 16,16                                ;XY 
    dw 0100h/PixelsPerByte + SpriteBase     ;SpriteAddr 1 - Large 1
     db 32,24                                ;XY 
    dw 0400h/PixelsPerByte + SpriteBase     ;SpriteAddr 2 - Large 2
     db 32,32                                ;XY 
    dw 0800h/PixelsPerByte + SpriteBase     ;SpriteAddr 3 - Mid 1
     db 24,16                                ;XY 
    dw 0980h/PixelsPerByte + SpriteBase     ;SpriteAddr 4 - Mid 2
     db 24,24                                ;XY 
    dw 0BC0h/PixelsPerByte + SpriteBase     ;SpriteAddr 5 - Small 1
     db 16,8                                 ;XY 
    dw 0C40h/PixelsPerByte + SpriteBase     ;SpriteAddr 6 - Small 2
     db 16,16                                ;XY 

	 
	 