#!/usr/bin/env python3

print()
print("Starting the Hack Assembler ...")

import symtblmgr
import parser
import translator

print()

'''
- init indep. SYMTBLMGR(.py)
  - build     SYM.TABLE	w/ pre-defs
    as a dict 

- handle GIVENNAME.ASM from cli :
  + outfile = GIVENNAME.HACK

- distill ( givenname.asm , givenname_filtmult.txt )
  - purge_mltln_comments : 
    - If first_char = "/*" , then keep parsing until passing "*/"
    > givenname_filtmult.txt
  - purge_whlln_comments / purge_inline_comments :
    - use string splitting
    > givenname_filtln.txt
    
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
