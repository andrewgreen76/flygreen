
===============================================================================
============================ Cool / useful tricks: ============================
=============================================================================== 

----------------------------- Formatting tricks: ------------------------------ 

printf("%.Xs\n", "string");		//with consts 
printf("%.*s\n", X, "string");		//with vars 
 - print the first X chars of string. 

printf("%Xs", "string");		//with consts 
printf("%*s\n", X, "string");		//with vars 
 - print empty spaces if strlength is less than X; 
 - end of string is X+ charslots away from the start of the line. 

printf("%X.Ys\n", "string"); 		//with consts 
printf("%X.*s\n", Y, "string"); 	//with vars 
 - trim string to first Y chars, tab end of str X spaces from start of line. 
 - args are eval'd and pushed onto the mem stack right-to-left. 

printf("%	X.Y	s\n", 		"string"); 
printf("%	*.*	s\n", 	X, Y, 	"string"); 

-------------------- Other potentially useful functions: ---------------------- 

swap() - swaps the integer values between two vars. 
qsort() - sorts elements in an array in ascending order. 
putwc() — Write Wide Character
putwchar() — Write Wide Character to stdout

------------------------- Other cool/useful tricks: --------------------------- 

Swapping values between two vars - XOR: 

	a ^= b ^= a ^= b ; 

 -or- use swap(); 

=============================================================================== 
