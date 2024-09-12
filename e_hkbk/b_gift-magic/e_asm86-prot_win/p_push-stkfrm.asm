
;;; Every stack frame helps keep track of the currently active subroutine (program flow). 
;;; Every stack frame means a call for a deeper scope.

;;; Base Pointer : 
;;;  . a frame of reference for monitoring/looking up/changing values within a scope. 
	
;;; Stack frame structure (build) :
;;;  .  caller-to-callee params , last to first
;;; <-> caller's CS:EIP (for ret) 
;;;  .  callee's loc vars , pushed top down 

;;; Return / tear-down - gives back ctrl to prev procedure : 
;;;  . pop off callee's vars 
;;;  . pop ret_addr off to caller's CS:EIP
;;; <->  prcdre N pops off params of N+1 
	
/*########################################################################################*/
/*#################################### PROLOGUE CODE #####################################*/
/*############################## Create a srout stack frame ##############################*/
/*########################################################################################*/
	push ebp            ; Save the old base pointer onto the stack
	mov ebp, esp
	sub esp , (frame_size)
	;; Then the compiler allocates and initializes the pieces of the stack frame , incl.
	;; the caller's CS:EIP. 
	
/*########################################################################################*/
/*###################### Code to use the new stack frame goes here #######################*/
/*########################################################################################*/
	
	;; Let's start studying stack frames with calling an arg-less srout that does nothing.
	;; So it's just the caller's CS:EIP. 
	
/*########################################################################################*/
/*#################################### EPILOGUE CODE #####################################*/
/*################ Tear down this stack frame , go back to the older one ##################*/
/*########################################################################################*/

	;; First , free the stack frame. Then do the rest : 
	mov esp, ebp        
	pop ebp             
