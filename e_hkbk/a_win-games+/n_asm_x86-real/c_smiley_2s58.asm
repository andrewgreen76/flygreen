
org 100h          ; Set the origin for the .COM file at offset 100h

mov ax, 13h       ; Set graphics mode (320x200, 256 colors)
int 10h           ; Call BIOS interrupt 10h

mov ax, 0A000h    ; Set AX to the base address of video memory in mode 13h
mov es, ax        ; Set ES to point to video memory

mov si, buffer  ; input : smiley face 
mov di, 0       ; output: framebuffer (offset)
mov bx, 8       ; number of rows
mov cx, 8       ; number of columns

paint_cluster:  ; given ANY CELL
mov al, [si]
mov es:[di], ax
mov es:[di+1], ax
mov es:[di+320], ax
mov es:[di+321], ax 
; next pixel : 
inc si      ; context of input buffer 
add di, 2   ; context of framebuffer 
dec cx      ; Are we done with the row ? 
jnz paint_cluster
; first col , next row : 
; Input buffer wraparound to next byte, so we are good there. 
add di, 624 ; manual end-of-row wraparound
mov cx, 8   ; reset leftover cluster count 
dec bx      ; Are we done with the sprite ? 
jnz paint_cluster

xor ah, ah        ; Prepare to wait for a key press
int 16h           ; BIOS interrupt to wait for key press

ret               ; Return from the program  

buffer: 
    db 00, 00, 47, 47, 47, 47, 00, 00
    db 00, 47, 00, 00, 00, 00, 47, 00
    db 47, 00, 47, 00, 00, 47, 00, 47
    db 47, 00, 00, 00, 00, 00, 00, 47
    db 47, 47, 00, 00, 00, 00, 47, 47
    db 47, 00, 47, 47, 47, 47, 00, 47
    db 00, 47, 00, 00, 00, 00, 47, 00
    db 00, 00, 47, 47, 47, 47, 00, 00
    
