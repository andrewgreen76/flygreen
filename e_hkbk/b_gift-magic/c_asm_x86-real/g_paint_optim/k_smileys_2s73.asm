
org 100h          ; Set the origin for the .COM file at offset 100h

mov ax, 13h       ; Set graphics mode (320x200, 256 colors)
int 10h           ; Call BIOS interrupt 10h

mov ax, 0A000h    ; Set AX to the base address of video memory in mode 13h
mov es, ax        ; Set ES to point to video memory  
mov di, 1         ; fb counter
mov al, 47        ; color 
mov bx, 16       ; num of smileys 
mov cx, 4474    ; to calc next smiley fb_offset 

paint:
add di, 3        
stosb
add di, 1        
stosb
add di, 1        
stosb
add di, 1       
stosb

add di, 631       
stosb
add di, 9       
stosb

add di, 627       
stosb
add di, 3       
stosb
add di, 5        
stosb
add di, 3        
stosb

add di, 625        
stosb
add di, 13       
stosb

add di, 625       
stosb
add di, 1        
stosb
add di, 9        
stosb
add di, 1        
stosb

add di, 625       
stosb
add di, 3        
stosb
add di, 1       
stosb
add di, 1       
stosb
add di, 1       
stosb
add di, 3       
stosb

add di, 627       
stosb
add di, 9       
stosb

add di, 631       
stosb
add di, 1       
stosb
add di, 1       
stosb
add di, 1       
stosb

;;;;;;;;;;;;;;;;;;;;
sub di, cx 
dec bx
jnz paint
;;;;;;;;;;;;;;;;;;;;

xor ah, ah        ; Prepare to wait for a key press
int 16h           ; BIOS interrupt to wait for key press

ret               ; Return from the program  

