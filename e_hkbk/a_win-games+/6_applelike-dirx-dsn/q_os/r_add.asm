	

	;jmp $		      ; $ - current mem addr
	;times 510-($-$$) db 0	; $$ - start of current section ; $-$$ = [3-0]
	;db 0x55, 0xaa

	
