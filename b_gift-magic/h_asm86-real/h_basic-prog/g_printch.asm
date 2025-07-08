
/**********************************************************************
			PRINTING A CHAR TO CONSOLE

To do this , we have to load the correct values into the ACCUMULATOR register 
and call upon the appropriate service with a certain INTERRUPT VECTOR. 
**********************************************************************/

	org 100h    
	
	mov ah, 0eh  	; display char on the console

	; al <- char for input. The mov instructions below do the same thing. 
	mov al, 'B'	; (a) 	ASCII char can go in ' ' 
	mov al, 66	; (b) 	ASCII char's decimal representation 
	mov al, 42h	; (c)	ASCII char's hex representation 
	
	int 10h      	; BIOS interrupt vector for video / console services
	ret          

/**********************************************************************
Using decimal or hex representation for char in 'al' can come in handy 
in case if you need to print a non-symbolic character like a line feed (10) 
or if you need to terminate the string with null (0). In the end the given 
value is mapped to its binary equivalent per the ASCII standard.  
**********************************************************************/

/**********************************************************************
The interrupt you send will dictate the CONTEXT OF EXECUTION. 

You can think about what values to load into the register and then 
which interrupt vector to use or think the other way around. 

Whatever the case , the interrupt call must FOLLOW , NOT PRECEDE , 
the register-load instructions. 
**********************************************************************/

	;; 
