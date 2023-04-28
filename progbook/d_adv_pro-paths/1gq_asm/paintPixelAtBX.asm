org 100h       
mov ax, 13h 
int 10h       
mov ax, 40960
mov ds, ax
mov ax, 2Fh         
mov bx, 0 ; will hold addr of pxl to paint in.   
pntLnClr: 
mov [bx],ax ; paint color in ax into pixel at bx. 
inc bx
cmp bx, 40
JL pntLnClr
mov ah, 0 
int 16h 
ret