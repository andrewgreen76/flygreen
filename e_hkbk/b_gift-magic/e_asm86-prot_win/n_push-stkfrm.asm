
;;; Stack frame structure (build) :
;;;  . N pushes params for N+1 last to first  <->  push in-caller post-call (ret) IP
;;;  . N+1 new srout loc vars pushed top down 

;;; Return / tear-down - gives back ctrl to prev prcdre : 
;;;  . pop off local vars of N+1 
;;;  . pop ret_addr off to IP (N)  <->  prcdre N pops off params of N+1 
	
/*########################################################################################*/
/*#################################### PROLOGUE CODE #####################################*/
/*################################ Create a stack frame ##################################*/
/*########################################################################################*/
	push ebp            ; Save the old base pointer onto the stack
	mov ebp, esp        
	;; The expectation is that BP would be manipulated (for changing things around
	;;   the scope/stack)  but SP would remain the same. 
/*########################################################################################*/
/*########################################################################################*/
/*########################################################################################*/
	
	; ... (code to use the new stack frame goes here)

/*########################################################################################*/
/*#################################### EPILOGUE CODE #####################################*/
/*############################# Restore the old stack frame ##############################*/
/*########################################################################################*/
	mov esp, ebp        
	pop ebp             
/*########################################################################################*/
/*########################################################################################*/
/*########################################################################################*/
	
/*
"
Creating a stack frame organizes and manages local variables, function parameters, 
  and return addresses, ensuring that function calls and returns are handled correctly 
  and that each function's execution context is preserved.
"
*/
