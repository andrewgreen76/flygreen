
org 100h          ; Set the origin for the .COM file at offset 100h

mov ax, 13h       ; Set graphics mode (320x200, 256 colors)
int 10h           ; Call BIOS interrupt 10h

mov ax, 0A000h    ; Set AX to the base address of video memory in mode 13h
mov es, ax        ; Set ES to point to video memory       
mov al, 47              ; color 


mov di, 4        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 6        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 8        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 10        ; "mov di, ?l" cannot be used.
mov es:[di], al

mov di, 642        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 652        ; "mov di, ?l" cannot be used.
mov es:[di], al

mov di, 1280        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 1284        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 1290        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 1294        ; "mov di, ?l" cannot be used.
mov es:[di], al

mov di, 1920        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 1934        ; "mov di, ?l" cannot be used.
mov es:[di], al

mov di, 2560        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 2562        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 2572        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 2574        ; "mov di, ?l" cannot be used.
mov es:[di], al

mov di, 3200        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 3204        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 3206        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 3208        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 3210        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 3214        ; "mov di, ?l" cannot be used.
mov es:[di], al

mov di, 3842        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 3852        ; "mov di, ?l" cannot be used.
mov es:[di], al

mov di, 4484        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 4486        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 4488        ; "mov di, ?l" cannot be used.
mov es:[di], al
mov di, 4490        ; "mov di, ?l" cannot be used.
mov es:[di], al

xor ah, ah        ; Prepare to wait for a key press
int 16h           ; BIOS interrupt to wait for key press

ret               ; Return from the program  

