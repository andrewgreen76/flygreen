
MemDump:			;Dump [es:bp] for bx bytes
	push ax
	push bx
	push cx 
			mov ax,es
			mov al,ah
			call Printhex
			mov ax,es
			call Printhex
			mov al,':'
			call PrintChar
			mov ax,bp
			mov al,ah
			call Printhex
			mov ax,bp
			call Printhex
			call NewLine
MemDumpAgain:	
			mov al, [es:bp]
			call Printhex
			call PrintSpace
			inc bp
			dec bx
			mov al,bl
			ifdef SmallScreen
				and al,00000011b
			else
				and al,00000111b
			endif
			jne MemDumpAgain	
			
			
		ifdef SmallScreen
			add bx,4
			sub bp,4
		else
			add bx,8
			sub bp,8
		endif
		
			
MemDumpCharAgain:
			mov al,[es:bp]
			cmp al,' '
			jg MemDumpOkChar
			mov al,'.'
MemDumpOkChar:			
			call PrintChar
			inc bp
			dec bx
			mov al,bl
			ifdef SmallScreen
				and al,00000011b
			else
				and al,00000111b
			endif
			jne MemDumpCharAgain
			
			
			call NewLine
		
			cmp bx,0
			jne MemDumpAgain
	pop cx
	pop bx
	pop ax
	
	ret
DoMonitor:
	push ds
		push es
			push ax
				mov ax, @data
				mov es, ax
				mov ax, @data	
				mov ds, ax
			pop WORD PTR [ds:MonitorBak_AX]
		pop WORD PTR [ds:MonitorBak_ES]
	pop WORD PTR [ds:MonitorBak_DS]
	
	pop WORD PTR [ds:MonitorBak_IP]
	dec sp
	dec sp
	
	pushf
	pop WORD PTR [ds:MonitorBak_F]
	
	mov ax,WORD PTR [ds:MonitorBak_AX]
	push ax
	push bx
		mov bx,ax
		mov al,'A'
		
		call DoMonitorOneX
		
	pop bx
	pop ax
	push ax
	push bx
		mov al,'B'
		call DoMonitorOneX

ifdef SmallScreen
	call newline
endif
		
		mov bx,cx
		mov al,'C'
		call DoMonitorOneX

		mov bx,dx
		mov al,'D'
		call DoMonitorOneX
		
		call newline
		
		mov bx,WORD PTR [ds:MonitorBak_F]
		mov ax,'F '
		call doMonitorOne
		
		mov bx,WORD PTR [ds:MonitorBak_IP]
		mov ax,'PI'
		call doMonitorOne
		
		call newline
		
		mov bx,sp
		mov ax,'PS'
		call doMonitorOne
		
		mov bx,bp
		mov ax,'PB'
		call doMonitorOne

ifdef SmallScreen
	call newline
endif		
	
		mov bx,di
		mov ax,'ID'
		call doMonitorOne
		
		mov bx,si
		mov ax,'IS'
		call doMonitorOne
		
		call newline
		
		mov bx,cs
		mov ax,'SC'
		call doMonitorOne
		
		mov bx,WORD PTR [ds:MonitorBak_DS]
		mov ax,'SD'
		call doMonitorOne
		
ifdef SmallScreen
	call newline
endif
		
		mov bx,WORD PTR [ds:MonitorBak_ES]
		mov ax,'SE'
		call doMonitorOne
		
		mov bx,ss
		mov ax,'SS'
		call doMonitorOne
		
		call newline
		
		mov es,WORD PTR [ds:MonitorBak_ES]
		
		
		mov ax,WORD PTR [ds:MonitorBak_F]
		push ax
		popf
		mov ds,WORD PTR [ds:MonitorBak_DS]
	pop bx
	pop ax
	ret

DoMonitorGetIP:	
	pop bx
	push bx
	ret
DoMonitorOneX:	
	mov ah,'X'
DoMonitorOne:	
	call MonitorColon
	mov al,bh
	call Printhex
	mov al,bl
	call Printhex
	call PrintSpace
	ret
MonitorColon:	
	push ax	
	call PrintChar
	mov al,ah
	call PrintChar
	mov al,':'
	call PrintChar
	pop ax
	ret
Printhex:
	push ax
		mov ah,al
		and ah,11110000B
		ror ah,1	;can't use >1 on 8086
		ror ah,1
		ror ah,1
		ror ah,1
		call PrintHexChar
		mov ah,al
		and ah,00001111B
		call PrintHexChar
	pop ax
	ret
PrintHexChar:
	push ax
		cmp ah,9
		jle PrintHexCharNumber
		add ah,'A'-('0'+10)
PrintHexCharNumber:
		add ah,'0'
		mov al,ah
		call PrintChar
	pop ax
	ret
