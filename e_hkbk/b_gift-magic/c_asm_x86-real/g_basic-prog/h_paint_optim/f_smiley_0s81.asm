
org 100h          ; Set the origin for the .COM file at offset 100h

mov ax, 13h       ; Set graphics mode (320x200, 256 colors)
int 10h           ; Call BIOS interrupt 10h

mov ax, 0A000h    ; Set AX to the base address of video memory in mode 13h
mov es, ax        ; Set ES to point to video memory       

mov si, offset buffer   ; address of painted-pixel offsets    
mov al, 47              ; color 
mov bx, 4490            ; offset of last pixel to paint

get_next:          
mov dx, [si]      ; "mov ?x, [si]" yeilds erroneous results.
cmp dx, bx
jz last_one
                  ; not last one , will paint  
mov di, dx        ; "mov di, ?l" cannot be used.
mov es:[di], al
add si, 2
jmp get_next

last_one:
mov di, dx        ; "mov di, ?l" cannot be used.
mov es:[di], al

xor ah, ah        ; Prepare to wait for a key press
int 16h           ; BIOS interrupt to wait for key press

ret               ; Return from the program  

buffer: 
    dw  4, 6, 8, 10
    dw  642 , 652
    dw  1280, 1284, 1290, 1294
    dw  1920, 1934
    dw  2560, 2562, 2572, 2574
    dw  3200, 3204, 3206, 3208, 3210, 3214
    dw  3842, 3852
    dw  4484, 4486, 4488, 4490 