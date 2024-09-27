
	.386			; Minimum CPU specs required.
				; Here : A CPU architecture that supports 32-bit systems / protected mode. 

	
	.model flat		; .model : [mem segmn model] [calling convention]
				;   . calling convention - specifies how parameters are passed to procedures/subroutines 
				;
				; Here : flat memory segmentation model : memory is accessible/addressable 
				; in the form of one line from low to high with reference pointers
				; and offsets instead of referencing individual process segments
				; (CS, DS, etc.).

	
	.code			; Code segment : instructions start below.
				;
				; "start" is specified as the entry procedure in VSCode's
				;
				;         Linker -> Advanced -> Entry Point : [proc_label (main/start)]
				;
start PROC			; "PROC" is the directive for the start of a procedure/subroutine. 
	mov eax, 213		;
	add eax, 432		;
	ret			;
start ENDP			; Guess what "ENDP" stands for. 
	END start

/*
In 32-bit MASM programs for Windows : 
 |
 . "`main ENDP` marks the end of the procedure definition for the `main` function"
 |
 . "`END main` indicates the end of the source file and specifies the entry point 
      for the program, serving distinct purposes despite the apparent redundancy." 
*/
