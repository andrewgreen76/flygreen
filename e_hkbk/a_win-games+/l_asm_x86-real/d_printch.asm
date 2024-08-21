
	org 100h    

/****************************************************************
We are going to print a character to the console. To do this , 
we have to load the correct values into the ACCUMULATOR register 
and call upon the appropriate service with a certain INTERRUPT VECTOR. 
****************************************************************/
	
	mov ah, 0eh  ; display char on the console
	mov al, 'A'  ; input char goes here
	
	int 10h      ; interrupt vector for video / console services
		     ; (that includes the console) 

/****************************************************************
The interrupt you send will dictate the CONTEXT OF EXECUTION. 

You can think about what values to load into the register and then 
which interrupt vector to use or think the other way around. 

Whatever the case , the interrupt call must follow the values 
specified for the registers. 
****************************************************************/

	ret          

	;; 
