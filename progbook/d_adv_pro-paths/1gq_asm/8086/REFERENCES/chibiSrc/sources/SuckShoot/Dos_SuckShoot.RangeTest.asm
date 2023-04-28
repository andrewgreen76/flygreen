;Text after semicolon is comments, you don't need to type it in
	
    .model small		;Tell Assembler Memory Model to use
    .stack 1024			;Stack pointer area
	

	.code				;Code Segment (CS)
	
	mov ah, 0          	;0=Set Video mode (AL=Mode)
    mov al, 13h        	;mode 13 (VGA 320x200 256 color)
    int 10h            	;bios int
		
	call RandomizeEnemy
	
	
infloop:
	call ReadJoystick		;Read in the Joystick	%---1UDLR
	
	mov dh, byte ptr [PlayerX]
	mov dl, byte ptr [PlayerY]
	
	mov ah,4
	test al,00100000b	;Compare to Fire2
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

	shr ah,1
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
	
	call ShowEnemy
	call ShowTarget		;Show the new sprite position
	
	mov ax,0F000h
DoPause:
	dec ax
	jne DoPause
	
	
	call rangetestPlayer
	jnc skip
	
	call RandomizeEnemy

Skip:	
	call ShowEnemy
	
	call ShowTarget		;Remove old sprite
	
	;call RandomizeEnemy
	
	jmp infloop			;Repeat 

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
	mov al, byte ptr [EnemyScale]		;Scale *8
	xor al,255
	shr al,1
	and al,00011000b
	
	mov bl, byte ptr [EnemySprite]
	and bl,00000001h			;Frame *4
	shl bl,1
	shl bl,1
	add al,bl
	add al,4	;First Bat Sprite=+4 bytes

	inc byte ptr [EnemySprite]	
	
	mov si,offset SpriteInfo
	add si,ax			;Pos in SpriteData Table
	
	mov dh, byte ptr [EnemyX]
	mov dl, byte ptr [EnemyY]
	
	jmp ShowSprite
	
ShowTarget:
	mov dh, byte ptr [PlayerX]
	mov dl, byte ptr [PlayerY]
	mov si,offset SpriteInfo
	
	
;XOR sprite at (X,Y) pos (DH,DL)
ShowSprite:		
;Calculate Screen pos
	mov ax,0A000h 		;Screen base 
	mov es,ax
	mov ax, @code		;Point DS to this segment
	mov ds, ax
	
	push dx	
		xor ax,ax
		mov al,dh
		
		mov cl,[ds:si+2]
		shr cl,1	;/2
		shr cl,1	;Logical units (2px = 1lu)
		sub al,cl	;Center X
		
		rol ax,1	;*2
		
		
		
		
		mov di,ax
			
		mov ax,320	;320 bytes per line, 8 lines per block
		xor bx,bx
		mov bl,dl
		
		
		mov cl,[ds:si+3]
		shr cl,1	;/2
		sub bl,cl	;Center Y
		
		mul bx
		add di,ax
	pop dx				;ES:DI is VRAM Destination
	
;Draw XOR sprite SI
	
	mov cl,[ds:si+3]	;Height
	mov bl,[ds:si+2]	;Width
	mov si,[ds:si+0] ;DS:SI=Source bitmap
	
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
	add di,320			;Move down 1 line (320 pixels)
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
PixelsPerByte equ 1


RandomSeed dw 0		;2 bytes


;Random number Lookup tables
Randoms1:
	db 0Ah,9Fh,0F0h,1Bh,69h,3Dh,0E8h,52h,0C6h,41h,0B7h,74h,23h,0ACh,8Eh,0D5h
Randoms2:
	db 9Ch,0EEh,0B5h,0CAh,0AFh,0F0h,0DBh,69h,3Dh,58h,22h,06h,41h,17h,74h,83h
	
	
	
	include \SrcDOS\V1_ReadJoystick.asm
	
	include \SrcALL\V1_Random.asm
	
SpriteBase:				;Smiley, 1 byte per pixel
	incbin "\ResALL\SuckShoot\SuckShootDOS.raw"
SpriteInfo:	
    dw 0000h/PixelsPerByte + SpriteBase           ;SpriteAddr 0
     db 16,16                                     ;XY 
    dw 0100h/PixelsPerByte + SpriteBase           ;SpriteAddr 1
     db 32,24                                     ;XY 
    dw 0400h/PixelsPerByte + SpriteBase           ;SpriteAddr 2
     db 32,32                                     ;XY 
    dw 0800h/PixelsPerByte + SpriteBase           ;SpriteAddr 3
     db 24,16                                     ;XY 
    dw 0980h/PixelsPerByte + SpriteBase           ;SpriteAddr 4
     db 24,24                                     ;XY 
    dw 0BC0h/PixelsPerByte + SpriteBase           ;SpriteAddr 5
     db 16,8                                      ;XY 
    dw 0C40h/PixelsPerByte + SpriteBase           ;SpriteAddr 6
     db 16,16                                     ;XY 
