include \SrcALL\V1_Header.asm

	call ScreenInit
	
;First let's check the state of all our registers	
	
	call Domonitor		;Show all registers to screen
	call NewLine

;We can load a register pair in a single command 

;The format for our commands is:
;	COMMAND DESTINATION,SOURCE
;So after the command, we'll have a destination register on the LEFT - a Comma (,) then the source on the RIGHT
;A command like "MOV AX,1234h" tells the 8086 to "MOVE into AX value 1234h"



;Here we set AX to 1234 in Hexadecimal (4660 in decimal)
;AX is a 16 bit register pair made up of 8 bit registers AH and AL... AH is the High byte of AX... AL is the Low byte of AX
		
	
	mov ax,1234h		;Load 1234 in hex to 16 bit register AX
	call DoMonitorAX	;Show AX to the screen
	
;As well as being able to load the AX register pair... we can also load the two AH and AL parts of AX separately
	
	mov al,0AAh			;Load AA in hex into 8 bit register AL 
	
	call DoMonitorAX		;(the bottom half of AX)
	
	mov ah,0BBh			;Load BB in hex into 8 bit register AH
	
	call DoMonitorAX		;(the top half of AX)
	
	call NewLine
		
	
;during our programming,we will need to use various BASES...

;Normally we'll be used to DECIMAL - which is base 10, because each digit goes from 0123456789.. this is the default 

;We can also use Hexadecimal known as Base 16 because it has 16 digits... 0123456789ABCDEF... 
;to tell the assembler we're using hexadecimal, we need to put a H at the end of our number... 
;NOTE... A1h is a valid hexadecimal byte... but the assembler will get confused if the number 
;doesn't start with a digit... so add a Zero to the start and specify A1h as 0A1h

;Binary is also essential to assembly and computing in general... as it's Base 2 it only has 2 digits... 10
;To specify a binary number we put a B at the end of our number... eg: 10b - this is only two bits, but the value is effectively 00000010b 
	
;It's not just number systems we can use with our assembler though! We can specify ascii letters...
;To specify a SPACE (Character 32 in decimal/ 20h in hex) we just put it in quotes

;As well as just MOVING values into registers we can do simple maths!
; SUB AX,10h says 'SUBTRACT from AX the value 10 in HEX 	
	
	mov ax,128			;Load AX with Decimal 128 (Hex 80h)
	call DoMonitorAX	
	
	sub ax,10h			;Subtract from AX the value Hex 10 (Decimal 16)
	call DoMonitorAX	
	
	add ax,10b			;Add to AX the value Binary 10 (decimal 2)
	call DoMonitorAX	
	
	mov ah,' '			;Load AX with Character ' ' (decimal 32 / Hex 20h)
	call DoMonitorAX	

	add ah,al 			;Add AL to AH
	call DoMonitorAX	

	call NewLine
	call NewLine
	
;We've used AX in all the examples here... but we also have 16 bit registers BX, CX and DX!
;Just like AX - each of these has two 8 bit parts... so we can use BH/BL, CH/CL and DH,DL as 8 bit parts of them

;We can also copy a value from one register to another
	
	mov bx,0666h 		;Load 666 in Hex to BX
	call DoMonitorAXBX 	;Show AX & BX to the screen
	
	mov ax,bx			;Load AX with the value in BX
	call DoMonitorAXBX 	;Show AX & BX to the screen
	
	call NewLine
	
;There will be times we	want to swap two registers without losing either of the values... XCHG can do this for us.
;It's not just 16 bit registers - we can do this with the 8 bit parts too!
	
	
	mov ax,07777h 
	call DoMonitorAXBX 	;Show AX & BX to the screen	
	
	xchg ax,bx			;Swap AX and BX
	call DoMonitorAXBX	;Show AX & BX to the screen

	xchg ah,al			;Swap AH and AL in AX
	call DoMonitorAXBX	;Show AX & BX to the screen
	
	xchg bh,al			;Swap BH and AL 
	call DoMonitorAXBX	;Show AX & BX to the screen
   
;We've looked at the ADD and SUB commands for increasing and decreasing values - but there is another way!
;Many times we'll want to change a register - increasing it, or decreasing it by 1 - we can use INC and DEC for this.
;These commands use fewer bytes so are faster and smaller... they'll be handy for loop counters and things like that.
   
	call NewLine
   
	call DoMonitorAXBX
   
	inc ax				;Add 1 to AX
	
	dec bx				;Subtract 1 from BX
	
	call DoMonitorAXBX
	
	call NewLine
	
	call NewLine
	
	
	jmp $
	
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;	

	
DoMonitorAXBX:		;Subroutine to Show AX+BX To the screen	
	
	call DoMonitorAX		;Call subroutine DoMonitorAX
	call DoMonitorBX		;then Call subroutine DoMonitorBX
	call NewLine			;then Call subroutine NewLine
		
	ret				;Return to whatever called us!
	
DoMonitorAX:				;Show AX To the screen
	push bx
	push ax
		mov bx,ax
		mov al,'A'
DoMonitorNX:
		call DoMonitorOneX	;Function in the Monitor - shows [AL]X:BX
	pop ax
	pop bx
	ret
	
DoMonitorBX:				;Show AX To the screen
	push bx
	push ax
		mov al,'B'
		jmp DoMonitorNX

	
include \SrcAll\V1_BitmapMemory.asm
include \SrcAll\V1_Monitor.asm	

BitmapFont:
	incbin "\resALL\Font96.FNT"
BitmapFontEnd:

include \SrcALL\V1_Footer.asm

