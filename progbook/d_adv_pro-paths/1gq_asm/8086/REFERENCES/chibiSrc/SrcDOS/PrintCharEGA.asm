
ScreenInit:
	mov     ah, 0       ;0=Set Video mode (AL=Mode)
    mov     al, 0Dh 	;mode 13 (ega 320x200 16 color)
    int     10h         ;bios int
	ret
	
	
	
  ; Layout: 4-plane planar.  Each pixel color is determined by the combined
          ; value of bits in the four color planes.  Each color plane begins
          ; at a000:0.  To select a plane, use:

            ; OUT 3ceH, 0005H         ;set up for plane masking
            ; OUT 3c4H, n             ;n is: 0102H=plane 0; 0202H=plane 1
                                    ; ;      0402H=plane 2; 0802H=plane 3
            ; ...(write video data)...
            ; OUT 3c4H, 0f02H         ;restore normal plane mask


GetScreenPos:	;BH,BL = X,Y Returns ES:DI=Destination
	push bx
	push ax
		mov ah,0
		mov al,bh		;Xpos
		mov di,ax
		
		mov ah,0
		mov al,bl		;Ypos * 40
		mov bx,40
		mul bx			;AX*BX
		add di,ax
		
		mov ax,0A000h 	;Screen Base= A000h
		mov es,ax
	pop ax
	pop bx
	ret
	
GetScreenNextLine:
	add di,40		;Move down a line (40 bytes)
	ret

	
SetPalette:	;AL=Pal Num ;dx=-GRB color
	push di
	push si
	push dx
	push cx
	push bx
	push ax
		mov bl,al			;Color number
;Green Bits	
		mov cl,2			;CL=2
		mov al,dh	
		and al,00001000b	;g3 ----G---
		shr al,cl			;   ------G-
		mov bh,al
		mov al,dh
		and al,00000100b	;g2 -----G--
		shl al,cl			;   ---G----
		or bh,al
;Blue Bits
		mov al,dl	
		and al,00001000b	;b3 ----B---
		inc cl				;CL=3
		shr al,cl			;   -------B
		or bh,al
		mov al,dl
		and al,00000100b	;b2 -----B--
		shl al,1			;   ----B---
		or bh,al
;Red Bits
		mov al,dl	
		and al,10000000b	;r3 R-------
		rol al,cl			;	-----R--
		or bh,al
		mov al,dl
		and al,01000000b	;r2 -R------
		shr al,1			;   --R-----
		or bh,al
;Send to bios
		mov ax,1000h ;Function 10 - subfunction 0 
; (Set Palette color) 	;Color BL ... BH=--rgbRGB
		int 10h ;bios int 
	pop ax
	pop bx
	pop cx
	pop dx
	pop si
	pop di
	ret

	
	
PrintChar:		;print char AL
	push di
	push si
	push es
	push dx
	push cx
	push bx
	push ax
	push ds
		push ax
			mov ax,0F02h	;Default plane mask 0+1+2+3 ( F= 1+2+4+8)
			mov dx,03C4h		
			out dx,ax
				
			mov ah,0
			mov al,[ds:CursorY]
			mov bx,40*8		;40 bytes per line - 8 lines per char
			mul bx
			mov di,ax		
			
			mov ah,0
			mov al,[ds:CursorX]
			add di,ax		;DI=Screenpos

			mov si,offset BitmapFont
			mov ax, seg BitmapFont
			mov ds, ax		
		pop ax
		sub al,32			;No Chars below 32
		mov ah,0

		mov cl,3			;8 bytes per char in font
		rcl ax,cl			
		add si,ax			;SI=Font Source
		
		mov cx,8
		push es	
			mov ax,0A000h 	;Base of Vram
			mov es,ax
FontAgain:	
			mov al,[ds:si]	;Source font
			mov es:[di],al	;Dest Screen
			inc si			;Next byte of font
			
			add di,40		;Move down a line
			dec cx			;Next line
			jnz FontAgain	;repeat for other lines
		pop es
	pop ds
	inc [ds:CursorX]		;Move across screen
	cmp [ds:CursorX],40		;At right hand site?
	jne PrintCharNoNewLine
	call NewLine			;New Line
PrintCharNoNewLine:
	pop ax
	pop bx
	pop cx
	pop dx
	pop es
	pop si
	pop di
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
	