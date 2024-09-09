
/*
"
Creating a stack frame organizes and manages local variables, function parameters, 
  and return addresses, ensuring that function calls and returns are handled correctly 
  and that each function's execution context is preserved.
"
*/
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Create a stack frame ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	push ebp            ; Save the old base pointer onto the stack
	mov ebp, esp        
	;; The expectation is that BP would be manipulated (for changing things around
	;;   the scope/stack)  but SP would remain the same. 
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
	; ... (code to use the new stack frame goes here)

	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; Restore the old stack frame ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	mov esp, ebp        
	pop ebp             
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

	
	;; 
