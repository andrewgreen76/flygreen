  ; Layout: 4-plane planar.  Each pixel color is determined by the combined
          ; value of bits in the four color planes.  Each color plane begins
          ; at a000:0.  To select a plane, use:

            ; OUT 3ceH, 0005H         ;set up for plane masking
            ; OUT 3c4H, n             ;n is: 0102H=plane 0; 0202H=plane 1
                                    ; ;      0402H=plane 2; 0802H=plane 3
            ; ...(write video data)...
            ; OUT 3c4H, 0f02H         ;restore normal plane mask


ScreenInit:
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
	ret
	
GetScreenPos:	;BH,BL = X,Y   Returns ES:DI=Destination
	push bx
	push ax
		mov ah,0
		mov al,bh		;Xpos
		mov di,ax
		
		mov al,bl		;Ypos
		and al,11111110b
		
		and bl,00000001b
		jz GetScreenPos_OddLine
		xor di,2000h	;Alternate lines at offset 2000h
GetScreenPos_OddLine:		

		mov bx,80/2		;80 bytes per 2 lines (Ypos * 40)
		mul bx				;as lines are interlaced
		add di,ax
		
		mov ax,0B800h 	;Screen Base
		mov es,ax
	pop ax
	pop bx
	ret
	
GetScreenNextLine:
	push ax
		mov ax,di
		and ax,2000h	;See if we're doing interlaced part
		mov ax,di
		jz GetScreenNextLineDone
		add ax,80		;80 bytes per line (40*2)
GetScreenNextLineDone:	
		xor ax,2000h	;Alternate lines at offset 2000h
		mov di,ax
	pop ax
SetPalette:
	ret


PrintChar:
	push si
	push di
	push es
	push ds
	push dx
	push cx
	push bx
	push ax
		push ds
			push ax
				mov ax,0
				mov al,[ds:CursorY]
				mov bx,40*4*2		;40 bytes per line - 4 lines per char - 2 bytes per line
				mul bx					;(other 4 lines at different address)
				mov di,ax
				mov ax,0
				mov al,[ds:CursorX]	
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
		inc [ds:CursorX]
		cmp [ds:CursorX],40		;Are we at the end of the screen
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

	
PrintCharDoPair:
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
	

