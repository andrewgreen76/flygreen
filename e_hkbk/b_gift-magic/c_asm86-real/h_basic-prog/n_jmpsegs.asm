
	org 100h

	jmp 0x7c0:0xff 		; ?S:IP = seg:off
				; ?S better be CS or we are not where we are supposed to be.
				; We want to be executing something that is meant to be code. 

	ret
