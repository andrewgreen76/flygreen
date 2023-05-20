org 100h       
MOV AX, 13h 
int 10h       
MOV AX, 40960
MOV DS, ax
MOV AX, 2Fh         
MOV BX, 0 ;will hold addr of pxl to paint in.   
pntLnClr: 
MOV [bx], AX ;paint color in ax into pixel at bx. 
INC bx
CMP BX, 40
JL pntLnClr
MOV AH, 0 
int 16h 
RET
