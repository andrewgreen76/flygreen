#!/usr/bin/env python3
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
print()
print("Starting the Hack Assembler ...")
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
#import symtblmgr  
import parser
import translator
import sys
import os
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
def arg_or_fail():

    if(len(sys.argv) > 1): # "Presence of an argument" test
        asm_in = sys.argv[1]
        if os.path.exists(asm_in): # "Presence of the file" test
            if(".asm" in asm_in): # "Recognition as .asm" test 
                given_name, rest = asm_in.split('.')
                outfile = given_name + ".hack"
                #print("Creating", outfile, "...")
                return outfile
            else:
                print(f"The file '{asm_in}' is not recognized as an assembly file.")                
        else:
            print(f"The file '{asm_in}' is not in the working directory.")
    else:    
        print("Operand assembly file name not provided.")

#def start_sym_table():
#    print("Forgoing the creation of the symbol table ...")

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
print("The output file will be:", arg_or_fail())

'''
- init indep. SYMTBLMGR(.py)
  - build     SYM.TABLE	w/ pre-defs
    as a dict 
'''

'''
- handle GIVENNAME.ASM from cli :
  + outfile = GIVENNAME.HACK
'''

'''
- distill ( givenname.asm , givenname_filtmult.txt )
  - purge_mltln_comments : 
    - If first_char = "/*" , then keep parsing until passing "*/"
    > givenname_filtmult.txt
  - purge_whlln_comments / purge_inline_comments :
    - use string splitting
    > givenname_filtln.txt
'''

'''
- pass_for_LABELS (decls)
  > givenname.hack
|
- pass_for_vars ()
  > givenname.hack
|
- loop_to_trans ()
  > givenname.hack
    - If @ , instr_code = 0
      else   instr_code = 1

- clean-up :
  - delete sym.table
  - delete givenname_filtered.txt
'''

print()
