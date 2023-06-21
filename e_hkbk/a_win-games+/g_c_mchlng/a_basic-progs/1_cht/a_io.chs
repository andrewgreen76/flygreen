
===============================================================================
======================== I/O basics, functions, etc.: =========================
=============================================================================== 

					|	 print		  put	
Three data flow schemes: 		|	  out()	 	  out
|					|	 <-+--		 --+->	
(1) 	stdin: keyboard input. 		|	   | 		   | 
	stdout: output to console. 	|	 --+->		 <-+--	
(2)	char[] buffer 			|	  in()		  in
(3)	FILE stream. 			|	 scan		  get
					|	

------------ Writing, reading, skipping, composing, decomposing: -------------- 

stdin/out (i/o, key/con stream): 
|
printf("Name: %s, age: %d", n, a) 	-  comp string  -> stdout. 
scanf("%x", &var) 			-        stdin (-> one var). 

's' is for "string": 
|
sprintf(dstBf, "Sqrt of %d is %d", a,b) -   comp string  -> string buffer. 
sscanf(srcBf, "%s %d", month, &year) 	- string buffer (-> decomp). 

'f' is for "file": 
|
fprintf(dstFptr,"%d.%s\n", i, str) 	-   comp string  -> file. 
fscanf(srcFptr,"%s %d\n", &nome, &voto) -   file string (-> decomp).

 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 

putc(c, dstStrm/dstVar)	- 	 char  -> stream. 
c=getc(srcStrm/srcVar)	- stream char (-> var c). 
|	
putchar(c) 		- 	char  -> stdout. 
c=getchar() 		- stdin char (-> var). 
||
fputc(c, fptr)  	- 	char  -> file. 
c=fgetc(fptr)		-  file char (-> var). 
|	
puts(str) -   str -> stdout.  	
gets(str) - stdin -> str. 

