
org 100h          ; Set the origin for the .COM file at offset 100h
mov ax, 13h       ; Set graphics mode (320x200, 256 colors)
int 10h           ; Call BIOS interrupt 10h

mov ax, 0A000h    ; Set AX to the base address of video memory in mode 13h
mov es, ax        ; Set ES to point to video memory

mov ax, 47       
mov cx, 320       ; Number of pixels to paint (one line of the screen)
mov di, 0         ; Set DI to the start offset

rep stosb         ; Fill the screen with the color in AL  
                  ; 'stosb' stores AL_val at [ES:DI]

mov ah, 0         ; Prepare to wait for a key press
int 16h           ; BIOS interrupt to wait for key press
ret               ; Return from the program
