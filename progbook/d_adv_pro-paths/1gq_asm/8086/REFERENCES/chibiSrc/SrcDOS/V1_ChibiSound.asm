
;See:
;Mazidi M.A. - 80x86 IBM PC and Compatible Computers (Volumes I and II). Ass
;Pg 386 for more speaker info
;https://archive.org/details/80x86ibmpccompat0001mazi

		
;MASM61PROGUIDE - pg 215	
;https://www.mikrocontroller.net/attachment/450367/MASM61PROGUIDE.pdf
	
ChibiSound:   ;NVTTTTTT	Noise Volume Tone (N=1 highest pitch)
	
	cmp al,0
	je ChibiSound_Silent
	
	push ax
		mov ah,al
				;   CCAAMMMS  C=Counter select,  A=counter Access
							;M=counter Mode, S=counter Style
		mov al, 10110110b   ;M=3 - square wave, AA=3 Write LH Bytes to 42h
							;C=2 - Counter 2 select
		out 43h, al     
		
	
		and ah,00111111b	;Pitch bits
		
		xor al,al
		mov cl,2			;shift pitch
		ror ax,cl
				
		out 42h, al       	;L Byte - 0042 - counter 2
		mov al, ah  		;Send High Byte
		out 42h, al 		;H Byte - 0042 - counter 2
		
		
		in al, 61h      	;Get status of KB controller port B 
			;  R---PPST 	 R=Reset P= parity checks S=Speaker 
							;T=speaker Timer 
		or al, 00000011b	;Turn on the speaker   
		out 61h, al       	;Update KB controller port B
		and al,11111101b
		mov ah,al			;Store 'Off' setting for later
	pop bx
	
	mov cx,4000h			;Quiet tone length
	
	test bl,10000000b
	jnz ChibiSound_DoNoise	;Turn on noise?
	
	test bl,01000000b
	jnz ChibiSound_DoLoud
	
ChibiSound_Quiet:		
	
	loop ChibiSound_Quiet	;Wait for quiet tone
	jmp ChibiSound_Silent	;Turn off tone
	
ChibiSound_DoNoise:	
	mov cx,2000h			;Noise lengyh (2000=loud 1000=quiet)
		
	test bl,01000000b		;Volume bit
	
	mov bx,0010000001101010b	;Noise pattern
	
	jnz ChibiSound_Noise
	ror cx,1				;Quiet noise (1000h)
	
ChibiSound_Noise:
	ror bx,1				;Cycle noise pattern
	mov al,bl
	xor al,cl				;add in CH/CL
	add al,ch
	and al,00000010b		;Get one bit
	or al,ah				;Turn into a sound on/off toggle
	out 61h, al 
	loop ChibiSound_Noise
	
ChibiSound_Silent:	
	in al, 61h 			;Get status of KB controller port B 
		 ;  R---PPST 	 R=Reset P= parity checks S=Speaker 
							;T=speaker Timer 
	and al, 11111100b  	;Turn off the speaker 
	out 61h, al       	;Update KB controller port B
ChibiSound_DoLoud:
	ret
	