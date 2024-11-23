
	org 100h      

	mov ax, 13h ; graphics mode
	int 10h      
	mov ax, 40960 ; why is the framebuffer @ 40960 ?
	mov ds, ax  ; reference the framebuffer in data segment

	xor ax, ax   ; color        
	xor bx, bx   ; fb offset of pixel to paint

	paint:
	mov [bx],ax ; paint color in ax into pixel at bx.
	inc ax ; change color
	inc bx
	cmp bx, 320
	jl paint

	mov ah, 0
	int 16h
	ret

	;; 
