.model  small
.stack 

stack segment para stack
    db 64 dup (' ')
stack ends
data segment
data ends
code segment
    assume cs:code,ds:data,ss:stack
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
    
    ; 320x200 mode 13h
    mov ah,00h
    mov al,13h
    int 10h
    
	;mov bx,320
	mov cx,0
	mov dx,0
colLoop:
    ;draw a pixel: 
    mov ah,0ch	; OP TO DRAW PIXEL
    mov al,09h	; COLOR: 9 - LIGHT BLUE ; 8 - DARK GREY ; 7 - LIGHT GREY 
				; 6 - BROWN ; 5 - MAGENTA ; 4 - RED 
				; 3 - CYAN ; 2 - GREEN ; 1 - DARK BLUE ; 0 - nil			
	int 10h
	;
	inc cx
	cmp cx, 320
	jnz colLoop		; for every column. 
	;
	mov cx,0
	inc dx
	cmp dx,200
	jnz colLoop		; for every row. 	
	  
    ;wait for a key press
    mov ah,00h
    int 16h
    
    ;set back to text mode - 03h
    mov ah,00h
    mov al,03h
    int 10h
    
    ;term
    mov ah,4ch
    int 21h
    
code ends
end