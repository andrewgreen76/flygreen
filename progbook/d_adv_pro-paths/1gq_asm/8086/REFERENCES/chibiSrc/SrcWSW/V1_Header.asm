mains segment

@data 	equ 00000h
UserRam equ 00100h
@code 	equ 0F000h

SmallScreen equ 1
		
CursorX			equ UserRam
CursorY			equ UserRam+1

MonitorBak_AX 	equ UserRam+2
MonitorBak_F	equ UserRam+4
MonitorBak_IP   equ UserRam+6
MonitorBak_ES   equ UserRam+8
MonitorBak_DS   equ UserRam+8


ProgramStart:		;Needed for header