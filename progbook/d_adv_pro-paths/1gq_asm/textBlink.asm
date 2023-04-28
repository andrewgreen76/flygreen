	org 100h      
mov ax, 3 ;text mode 80x25, 16 colors, 8 pages (ah=0, al=3)
int 10h ;do it!

 
;cancel blinking and enable all 16 colors:
mov ax, 1003h
mov bx, 0
int 10h

;wait for any key press:
mov ah, 0
int 16h

ret