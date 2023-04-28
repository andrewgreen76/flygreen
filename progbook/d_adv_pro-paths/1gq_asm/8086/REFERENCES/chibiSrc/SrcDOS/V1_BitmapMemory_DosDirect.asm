
Locate:
		mov [CursorX],bh
		mov [CursorY],bl
	ret
NewLine:
		mov [CursorX],0
		inc [CursorY]
	ret
	
PrintSpace:
	push ax
		mov al,' '
		call PrintChar
	pop ax
	ret
	
PrintChar:
	push dx
	push ax
	push bx
		mov bx,0
		mov dl,[CursorX]
		mov dh,[CursorY]
		mov ah, 02h
		int 10h				;Locate
		
		mov dl,al
		mov ah, 02h
		int 21h				;Print
		inc [CursorX]
		cmp [CursorX],40
		jne PrintCharNoNewLine
		call NewLine
PrintCharNoNewLine:
	pop bx
	pop ax
	pop dx
	ret
	

ScreenInit:
	mov     ah, 0           ; int 10,0
    mov     al, 4           ; mode 4 (cga 320x200 4 color)
    int     10h             ; bios int
	ret
