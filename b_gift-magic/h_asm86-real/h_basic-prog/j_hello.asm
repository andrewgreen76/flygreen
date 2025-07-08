
	org 100h

	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	print:
	    mov si, msg ; buffer's offset
	    mov ah, 0eh ; print chars 
	._loop:
	    lodsb
	    cmp al, 0   ; if EOS
	    je .done
	    int 10h     ; when actual charprint happens 
	    
	    jmp ._loop  ; keep scanning 
	.done:
	    ret 	; ret FROM THE LATEST CALL 

	main:             
	    call print

	ret		; ret from main 

	msg: db 'Hello, world!', 0 


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Short , dumb explanation of "msg" : 
	;   The word "msg" represents the address of the array of 
	;   bytes "Hello, world!"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; Long , full explanation : 
	;   Here "message" is not a variable like the variables we are 
	;   used to in HLL's. "message" is something called a LABEL, 
	;   a human-readable SYMBOL that will later on be mapped within 
	;   a structure called a SYMBOL TABLE to an address of a piece 
	;   of memory large enough for a buffer containing the respective 
	;   text, "Hello, world!"
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	; In the world of emu8086 data cannot be placed between the directives 
	;   and the main code as data cannot be executed. So it must be placed 
	;   after the declaration of end of code. 
	;
	; Alternatively , anything could be placed between the directives 
	;   and the main code but the build utilities need to see that 
	;   there is a way to get to the main code , like using a jump 
	;   instruction. 
	;   
	;   *********************************
	;   org 100h
	;   jmp main 
	;   message: db 'Hello, world!', 0 
	;   main:             
	;       mov ah, 0eh
	;       mov al, 'A'
	;       int 10h
	;   ret
	;   *********************************
	;   
	;   However, placing buffers after the code section 
	;   in legacy assembly source files is common practice. 
	;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
