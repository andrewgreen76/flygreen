======================= Win shells cheat sheet =======================
======================================================================

.CMD: designed to run single commands (one at a time). 
 - has a programming language to run scripts; 
 - is a command interpreter; 
 - thought to be safer than .bat . 
.BAT: designed to start entire programs. 
 - a scripting language; 
 - has an interpreter. 
 
======================================================================

Commands - COMMON/CMD:
------------------------------------------------
cls					clear screen 
color bf			coloring console and text 

echo [text]			print the text to the console 
echo.				print a blank line to the console 
echo [text] > [filename.ext]	create a file with a one line of text 

del /f [filename.ext]		deletes the specified file 

[run.exe] [n]>[file.txt/NUL]	runs an app, prints std/text output. 

	n is 1 for stdout if you wish it to extract expected stream output
	n is 2 for stderr if you wish it to extract error messages. 
	file.txt - output file ; use NUL for the stream to go nowhere. 

type [filename.ext]		echo what's in the indicated file
type nul > [filename.ext]	create an empty file 
copy con [filename.ext]		create a file with text in it 
gcc [class].c -o [start.exe]	compile a C-based program 

======================================================================

Commands - BATCH:
------------------------------------------------
:[nameOfLabel]		
	denotes a point in the self-same batch that the machine can be 
	re-directed to. 
	
======================================================================

Running commands in a file: 
 - Hint: it's a batch/cmd file. 
 
======================================================================

errorlevel
