.model  small
.stack 

stack segment para stack	; .MODEL SMALL
    db 64 dup (' ')			; .STACK 1024
stack ends

data SEGMENT PARA 'DATA'
data ends

code SEGMENT PARA 'CODE'
	
	mov ah, 0
	mov al, 13h		; 320 x 200 x 256
	int 10h
	
	mov dh, 1		; x
	mov dl, 1		; y
	
	call ShowSprite		; Show the AT starting position. 
	
infloop:
	mov ah, 01h		; Func 01h = check if keybuffer is empty. 
	int 16h			; to do with key press
	jz infloop		;
	
	call ShowSprite		; ? remove the old sprite ? 
	
	mov ah, 00h		; Func 0Eh = read a key from buffer (keycode in AH). 
	int 16h			; to do with key press
	
	cmp ah, 48h		; 
	jnz CurNotUp	; 
	cmp dl, 0		; 
	jz CurNotUp		; 
	dec dl			; 
	
CurNotUp:			; 
	cmp ah, 50h			; 
	jnz CurNotDown			; 
	cmp dl, 24			; 
	jz CurNotDown			; 
	inc dl			; 

CurNotDown:			; 
	cmp ah, 4Bh			; 
	jnz CurNotLeft			; 
	cmp dh,0			; 
	jz CurNotLeft			; 
	dec dh			; 
	
CurNotLeft:			; 
	cmp ah,4Dh			; 
	jnz CurNotRight			; 
	cmp dh, 39			; 
	jz CurNotRight			; 
	inc dh			; 
	
CurNotRight:			; 
	call ShowSprite		; Show the new sprite position. 
	jmp infloop			; Repeat

; XOR sprite at x,y. 
ShowSprite:			; Calculate screen position. 
	mov ax,0A000h			; screen base
	mov es,ax
	mov ax, @code	; Point DS to this segment. 
	mov ds, ax
	
	push dx
		mov ax,8	; 8 Bytes per 8x8 block. 
		mul dh
		mov di,ax
		
		mov ax, 8*320	; 320 Bytes per line, 8 lines per block. 
		mov bx,0
		add bl,dl
		mul bx
		add di,ax
	pop dx				; ES:DI is VRAM dest. 
	
; Draw XOR sprite. 
	mov si, offset BitmapTest			; DS:SI - source bitmap
	mov cl, 8							; cl = height. 
	
DrawBitmap_Yagain:
	push di
		mov ch, 8						; ch = width. 
DrawBitmap_Xagain:
		mov al, DS:[SI] 
		xor al, ES:[DI] 					; XOR with current screen data. 
		mov ES:[DI], al
		inc si
		inc di
		dec ch
		jnz DrawBitmap_Xagain				; Next horizontal pixel
	pop di
	add di,320							; Move down 1 line (320 pixels). 
	inc bl
	dec cl
	jnz DrawBitmap_Yagain
	ret						; MAY NEED 		MOV AX, 4CH ; INT 21H
	
		;wait for a key press
		mov ah,00h
		int 16h
		
		;set back to text mode - 03h
		mov ah,00h
		mov al,03h
		int 10h
		
		mov ah, 4ch
		int 21h
		
BitmapTest:								; Smiley, 1 Byte per pixel. 
	DB 00h,00h,0Eh,0Eh,0Eh,0Eh,00h,00h	; 0
	DB 00h,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,00h	; 1
	DB 0Eh,0Eh,03h,0Eh,0Eh,03h,0Eh,0Eh	; 2
	DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh	; 3
	DB 0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh,0Eh	; 4
	DB 0Eh,0Eh,02h,0Eh,0Eh,02h,0Eh,0Eh	; 5
	DB 00h,0Eh,0Eh,02h,02h,0Eh,0Eh,00h	; 6
	DB 00h,00h,0Eh,0Eh,0Eh,0Eh,00h,00h	; 7
	
CODE ENDS
END
