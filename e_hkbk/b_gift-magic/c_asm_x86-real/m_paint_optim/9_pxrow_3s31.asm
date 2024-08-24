
org 100h          ; Set the origin for the .COM file at offset 100h
mov ax, 13h       ; Set graphics mode (320x200, 256 colors)
int 10h           ; Call BIOS interrupt 10h

mov ax, 40960     ; Set AX to the base address of video memory in mode 13h
mov ds, ax        ; Set ES to point to video memory

mov ax, 47       
mov bx, 0         ; Set DI to the start offset
                  
paint:
mov [bx], ax
inc bx
cmp bx, 320
jl paint

mov ah, 0         ; Prepare to wait for a key press
int 16h           ; BIOS interrupt to wait for key press
ret               ; Return from the program

