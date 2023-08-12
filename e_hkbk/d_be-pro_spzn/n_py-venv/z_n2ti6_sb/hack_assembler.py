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
def is_arg_good():

    if(len(sys.argv) > 1): # "Presence of argument 1" test
        asm_in = sys.argv[1]
        if os.path.exists(asm_in): # "Presence of the file" test
            if(".asm" in asm_in): # "Recognition as .asm" test
                return True                
            else:
                print(f"The file '{asm_in}' is not recognized as an assembly file.")                
                return asm_in
        else:
            print(f"The file '{asm_in}' is not in the working directory.")
            return False
    else:    
        print("Operand assembly file name not provided.")
        return False

#def start_sym_table():
#    print("Forgoing the creation of the symbol table ...")

def make_hack_file():
    given_name, the_rest = sys.argv[1].split('.')
    outfile = given_name + ".hack"
    print("Creating", outfile, "...")
    

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
    
if(asm_in := is_arg_good()):
    make_hack_file()

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
