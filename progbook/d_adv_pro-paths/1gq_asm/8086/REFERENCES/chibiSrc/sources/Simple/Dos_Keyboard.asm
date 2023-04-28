;Text after semicolon is comments, you don't need to type it in
	
    .model small		;Tell Assembler Memory Model to use
    .stack 1024			;Stack pointer area
	.code				;Code Segment (CS)
	
	mov ah, 0          	;0=Set Video mode (AL=Mode)
    mov al, 13h        	;mode 13 (VGA 320x200 256 color)
    int 10h            	;bios int
	
	mov dh,1			;Xpos
	mov dl,1			;Ypos
	
	call ShowSprite		;Show the starting position
	
infloop:
	mov	ah, 01h			;Func 01h = Check if the Keybuffer is empty
	int	16h				;Int 16=Keyboard interrupt
	jz infloop			;Check if no key pressed

	call ShowSprite		;Remove old sprite
	
	mov	ah, 00h			;Func 0Eh = Read a key from buffer(keycode in AH)
	int	16h				;Int 16=Keyboard interrupt
	
	cmp ah,48h			;Compare to UP
	jnz CurNotUp
	cmp dl,0			;Check it at the top of the screen
	jz CurNotUp
	dec dl				;Move Up
CurNotUp:	

	cmp ah,50h			;Compare to Down
	jnz CurNotDown
	cmp dl,24			;Check it at the bottom of the screen
	jz CurNotDown
	inc dl				;Move Down
CurNotDown:	

	cmp ah,4Bh			;Compare to Left
	jnz CurNotLeft
	cmp dh,0			;Check it at the left of the screen
	jz CurNotLeft
	dec dh				;Move Left
CurNotLeft:	

	cmp ah,4Dh			;Compare to Right
	jnz CurNotRight
	cmp dh,39			;Check it at the right of the screen
	jz CurNotRight
	inc dh				;Move Right
CurNotRight:	

	call ShowSprite		;Show the new sprite position
	jmp infloop			;Repeat 

;XOR sprite at (X,Y) pos (DH,DL)
ShowSprite:		
;Calculate Screen pos
	mov ax,0A000h 		;Screen base 
	mov es,ax
	mov ax, @code		;Point DS to this segment
	mov ds, ax
	
	push dx	
		mov ax,8		;8 bytes per 8x8 block
		mul dh
		mov di,ax
			
		mov ax,8*320	;320 bytes per line, 8 lines per block
		mov bx,0
		add bl,dl
		mul bx
		add di,ax
	pop dx				;ES:DI is VRAM Destination
	
;Draw XOR sprite	
	mov si,offset BitmapTest ;DS:SI=Source bitmap
	mov cl,8			;Height
DrawBitmap_Yagain:
	push di
		mov ch,8		;Width
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
	inc bl
	dec cl
	jnz DrawBitmap_Yagain
	ret		
	
BitmapTest:				;Smiley, 1 byte per pixel
	DB 00h,00h,0Eh,0Eh,0Eh,0Eh,00h,00h     ;  0
	DB 00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h     ;  1
	DB 0Eh,0Eh,03h,0Eh,0Eh,03h,0Eh,0Eh     ;  2
	DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;  3
	DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh     ;  4
	DB 0Eh,0Eh,02h,0Eh,0Eh,02h,0Eh,0Eh     ;  5
	DB 00h,0Eh,0Eh,02h,02h,0Eh,0Eh,00h     ;  6
	DB 00h,00h,0Eh,0Eh,0Eh,0Eh,00h,00h     ;  7

	