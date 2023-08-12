#!/usr/bin/env python3

print()
print("Starting the Hack Assembler ...")

#import symtblmgr  
import parser
import translator
import sys

def treat_asm_name():
    asm_in = sys.argv[1] if len(sys.argv) > 1 else print("\nProvide name of .asm file to process, as in: python3 hkasmr.py __fname__.asm\n")
    print("Processing", asm_in, "...")
    given_name, rest = asm_in.split('.')
    print("Creating", given_name + ".hack")

def start_sym_table():
    print("Forgoing the creation of the symbol table ...")

treat_asm_name()
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
