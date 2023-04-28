;Draw a line in a graphics mode

 ;By extension, draws a yellow line in the upper-left.
;A good example of how to efficiently use INC, CMP,
;and a conditional jump for repetitive tasks.

 MOV AH, 00h
MOV AL, 13h
int 10h

 ;The above three lines just switch to 320x200 256-color VGA.

MOV AX, 40960
MOV DS, AX
;a000h = 40960 decimal
MOV AX, 44h
;44h is yellow! ;)
MOV BX, 0000
START:
 MOV [bx], ax
INC bx
CMP BX, 20
JL START

 ;This waits until BX reaches 20, then exits!

MOV AH, 00
MOV AL, 4Ch ;terminate program
int 21h
