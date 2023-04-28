        .model  tiny
		.STACK
        .code
        org     100h

start:  mov     ax, 0013h       ;set 320x200x8 graphic screen
        int     10h
		
		MOV AX, 0A000h
		MOV es, AX
		
        mov     byte ptr es:[320*100+100], 28h  ;draw bright red pixel

        mov     ah, 0           ;wait for keystroke
        int     16h
		
        mov     ax, 0003h       ;restore normal text mode screen
        int     10h
		
        ;ret                     ;return to OS
		
		MOV AH, 4CH
		INT 21H
		
        end     start