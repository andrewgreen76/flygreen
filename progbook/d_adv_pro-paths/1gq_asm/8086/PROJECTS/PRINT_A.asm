stack segment para stack
    db 64 dup (' ')
stack ends
data segment PARA 'DATA'
data ends
code segment PARA 'CODE'

	MAIN PROC FAR
		MOV DL, 'A'
		MOV AH, 6H
		INT 21H
		RET
	MAIN ENDP

code ends
end