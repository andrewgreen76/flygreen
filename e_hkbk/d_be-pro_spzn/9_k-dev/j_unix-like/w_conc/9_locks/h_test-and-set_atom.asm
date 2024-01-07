
	;; The single fact that the called function is implemented in assembly, abstracted from the compiler, 
	;; is what makes it atomic on the compiler level. 
	
__sync_lock_test_and_set:
    mov eax, [lock]   ; Load the current value of 'lock' into eax
    mov [lock], 1     ; Set 'lock' to 1
    ret               ; Return the original value stored in eax

	;; 
