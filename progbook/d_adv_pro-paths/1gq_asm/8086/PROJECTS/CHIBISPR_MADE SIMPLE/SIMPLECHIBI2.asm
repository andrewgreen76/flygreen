.model  small
.stack 

stack segment para stack	; .MODEL SMALL
    db 64 dup (' ')			; .STACK 1024
stack ends

data SEGMENT PARA 'DATA'
data ends

code SEGMENT PARA 'CODE'
    assume cs:code,ds:data,ss:stack
    mov ax,data
    mov ds,ax
    mov ax,stack
    mov ss,ax
	
		mov ah, 0
		mov al, 13h		; 320 x 200 x 256
		int 10h
		
		mov dh, 0		; x
		mov dl, 0		; y
		
		
		
		mov ax,0A000h			; screen base
		mov es,ax
		
		mov ax,0
		mov di,ax	; ES:DI is VRAM dest. 
		
	; Draw XOR sprite. 
		
		mov AL, 0Dh 
		xor AL, es:[DI] 					; XOR with current screen data. 
		mov es:[DI], al
		
		
		
		;wait for a key press
		mov ah,00h
		int 16h
		
		;set back to text mode - 03h
		mov ah,00h
		mov al,03h
		int 10h
		
		mov ah, 4ch
		int 21h
		
code ends
end