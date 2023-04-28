


;	Rom Footer
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	org 0xFFF0 ;(65520)
	
	db	0xEA			; jmp far
	dw	ProgramStart	; Entry point
	dw	0xF000			; In bank 0xF000
	db	0x00
	db	0xCD		; Developer ID
	db	0x01		; Color mode
	db	0x01		; Cart number
	db	0x00		; Reserved
	db	0x02		; Cart Size (4 Mb)
	db	0x00		; SRAM size (0 Kb)
	db	0x04		; Horizontal game
	db	0x00		; Additional capabilities
	dw	0x0000	; Checksum (?)
mains ends