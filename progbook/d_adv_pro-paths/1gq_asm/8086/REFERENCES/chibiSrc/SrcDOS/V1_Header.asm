
    .model small
    .stack 1024

    .data
UserRam BYTE 256 DUP (0)
	
	
CursorX			equ UserRam
CursorY			equ UserRam+1

MonitorBak_AX 	equ UserRam+2
MonitorBak_F	equ UserRam+4
MonitorBak_IP   equ UserRam+6
MonitorBak_ES   equ UserRam+8
MonitorBak_DS   equ UserRam+10
    .code

	mov ax, @data		;ES points to our Data segment
	mov ds, ax
	
	mov ax, @code		;DS points to our Code segment
    mov es, ax