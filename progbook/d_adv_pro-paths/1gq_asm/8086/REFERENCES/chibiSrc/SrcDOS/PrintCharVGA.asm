
ScreenInit:
	mov ah, 0          ;0=Set Video mode (AL=Mode)
    mov al, 13h        ;mode 13 (VGA 320x200 256 color)
    int 10h            ;bios int
	ret
	
	
 ; VGA 320x200, 256-color (video mode 13H)
 ; Segment: a000
  ; Layout: Linear, packed-pixel.  This mode uses one byte (8 bits) per
          ; pixel.  The colors displayed depend on the palette settings.

          ; Each scan line is 320 bytes long and there are 200 scan lines
          ; (regen size=64,000 bytes).  Each byte contains 1 pixel (64,000
          ; total pixels).

GetScreenPos:	;BH,BL = X,Y	Returns ES:DI=Destination
	push bx
	push ax
		mov ah,0
		mov al,bh		;Xpos
		mov di,ax
		
		mov ah,0
		mov al,bl		;Ypos*320
		
		mov bx,320		;320 bytes per line
		mul bx
		
		add di,ax
		mov ax,0A000h 	;Screen base
		mov es,ax
	pop ax
	pop bx
	ret
	

GetScreenNextLine:
	add di,320			;Move down 1 line
	ret

	
SetPalette:		;AL=Color num ... DX=-GRB
	push dx
	push cx
	push bx
	push ax 
		mov bx,ax	;Color
		mov cl,2
		
		mov al,dh
		and al,00001111b ;----GGGG
		shl al,cl		 ;--GGGGgg
		mov ch,al	;G (6 bit 0-63)

		mov al,dl
		and al,11110000b ;RRRR----
		shr al,cl		 ;--RRRRrr
		mov dh,al	;r (6 bit 0-63)	
		
		mov al,dl
		and al,00001111b ;----BBBB
		shl al,cl		 ;--BBBBbb
		mov cl,al	;b (6 bit 0-63)

		mov bh,0 		
		mov ax,1010h 	;10.10 Set One DAC Color Register
		int 10h ;Set Color...Color= BL  R=DH  G=CH  B=CL   
	pop ax								;RGB = 0-63
	pop bx
	pop cx
	pop dx
	ret
	
	
	
	
PrintChar:
	push si
	push di
	push dx
	push cx
	push bx
	push ax
		push ds
			push ax
				mov ah,0
				mov al,[ds:CursorY]
				mov bx,320*8	;320 bytes per line - 8 lines per char
				mul bx
				mov di,ax
				
				mov ah,0
				mov al,[ds:CursorX]		
				mov cl,3		;Xpos * 8
				rcl ax,cl
				add di,ax		;DI= Screen Pos
				
				mov si,offset BitmapFont
				mov ax, seg BitmapFont
				mov ds, ax		
			pop ax
			sub al,32			;No Chars below 32
			
			mov ah,0
			mov cl,3			;8 bytes per char in font
			rcl ax,cl			
			add si,ax			;SI=Font Source
			
			mov cx,8			;Line Count
			push es
				mov ax,0A000h 
				mov es,ax
FontAgainVGA:	
				mov al,[ds:si]
				push di
					mov ch,8
FontNextPixel:					;Convert 1bpp to 8bpp color 15	
					mov ah,0
					rcl al,1	;Get 1 bit of font
					rcl ah,1	;Shift it into AH
					mov dh,ah	;back up
					rcl ah,1	;Shift 1 bit
					or ah,dh	;or in backup
					rcl ah,1	;Shift 1 bit
					or ah,dh	;or in backup
					rcl ah,1	;Shift 1 bit
					or ah,dh	;or in backup
					mov es:[di],ah
					inc di
					dec ch		;Next Pixel
					jnz FontNextPixel
				pop di
				inc si			;Inc Source Font address
				add di,320		;Mode Down A line
				Loop FontAgainVGA ;Dec CX, loop NZ (next line)
			pop es
		pop ds
		inc [ds:CursorX]
		cmp [ds:CursorX],40		;Check if we're at the end of the line?
		jne PrintCharNoNewLine
		call NewLine			;Move down a line
PrintCharNoNewLine:
	pop ax
	pop bx
	pop cx
	pop dx
	pop di
	pop si
	ret



Locate:
	mov [ds:CursorX],bh
	mov [ds:CursorY],bl
	ret
NewLine:
	mov [ds:CursorX],0	;Reset Xpos
	inc [ds:CursorY]	;Move down a line
	ret
	
	
PrintSpace:
	push ax
		mov al,' '
		call PrintChar
	pop ax
	ret
