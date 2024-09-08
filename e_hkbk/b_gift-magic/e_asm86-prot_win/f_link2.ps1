
					# Source files with "ingredients" being used - must be processed BEFORE other files
					#   that make use of them. A main file with unresolved symbols cannot be compiled. 

					########################################################################################

nasm -fwin32 [asm_src].asm		# (1) yields .obj from .asm

gcc [main].c [asm_src].obj -o main	# (2) GCC compiles .C file , yields .obj ; # GCC's linker fuses object files together.
    	     		      		#  .  Reminder : we use `-o [exec_name]` to generate the Output (executable).
					
main.exe				# (3) 

#