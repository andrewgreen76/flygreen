
org 100h          ; Set the origin for the .COM file at offset 100h

mov ax, 13h       ; Set graphics mode (320x200, 256 colors)
int 10h           ; Call BIOS interrupt 10h

mov ax, 0A000h    ; Set AX to the base address of video memory in mode 13h
mov es, ax        ; Set ES to point to video memory  
mov di, 0         ; fb counter
mov al, 47        ; color 
mov bx, 16       ; num of smileys 
mov cx, 4474    ; to calc next smiley fb_offset 

paint:
add di, 4        
mov es:[di], al
add di, 2        
mov es:[di], al
add di, 2        
mov es:[di], al
add di, 2       
mov es:[di], al

add di, 632       
mov es:[di], al
add di, 10       
mov es:[di], al

add di, 628       
mov es:[di], al
add di, 4       
mov es:[di], al
add di, 6        
mov es:[di], al
add di, 4        
mov es:[di], al

add di, 626        
mov es:[di], al
add di, 14       
mov es:[di], al

add di, 626       
mov es:[di], al
add di, 2        
mov es:[di], al
add di, 10        
mov es:[di], al
add di, 2        
mov es:[di], al

add di, 626       
mov es:[di], al
add di, 4        
mov es:[di], al
add di, 2       
mov es:[di], al
add di, 2       
mov es:[di], al
add di, 2       
mov es:[di], al
add di, 4       
mov es:[di], al

add di, 628       
mov es:[di], al
add di, 10       
mov es:[di], al

add di, 632       
mov es:[di], al
add di, 2       
mov es:[di], al
add di, 2       
mov es:[di], al
add di, 2       
mov es:[di], al

;;;;;;;;;;;;;;;;;;;;
sub di, cx 
dec bx
jnz paint
;;;;;;;;;;;;;;;;;;;;

xor ah, ah        ; Prepare to wait for a key press
int 16h           ; BIOS interrupt to wait for key press

ret               ; Return from the program  

