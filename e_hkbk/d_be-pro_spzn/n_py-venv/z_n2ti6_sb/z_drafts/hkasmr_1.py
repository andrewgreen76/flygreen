#!/usr/bin/env python3

print()
print("Starting the Hack Assembler ...")

#import symtblmgr  
import parser
import translator
import sys
import os

def treat_asm_name():
    asm_in = sys.argv[1] if len(sys.argv) > 1 else print("\nInvalid .asm file name\n")

    if os.path.exists(asm_in):
        print(f"The file '{asm_in}' exists.")
    else:
        print(f"The file '{asm_in}' does not exist.")
    
    given_name, rest = asm_in.split('.')
    outfile = given_name + ".hack"
    print("Creating", outfile, "...")
    return outfile

def start_sym_table():
    print("Forgoing the creation of the symbol table ...")

outfile = treat_asm_name()
start_sym_table()

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
