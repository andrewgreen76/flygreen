
===============================================================================
================================== FILE ops: ==================================
=============================================================================== 

Creating/opening a new file: 
 > FILE *fp;
 > fptr = fopen ("file_name", "mode");

Reading from and writing information to a file: 
 > fprintf(), fscanf(), fputc(), fgetc(), etc. 

Closing a file: 
 > fclose (fptr); 


File Mode	Description
 - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
r		reading. 
w		writing. If present, all data inside is truncated
a		append mode. The content within the file doesn't change.
r+		reading and writing from beginning
w+		reading and writing, overwriting a file
a+		reading and writing, appending to file


fwrite() - Write Items
fread()	- reads raw bytes from binary files.
fseek() - 

