#!/usr/bin/env python3
print()
print("Starting the Hack Assembler ...")

#import symtblmgr  
import parser
import translator
import sys
import os

progname = "prog"

#______________________________________ Function : ARG CHECK ___________________________________________
def is_arg_good():
    
    if(len(sys.argv) > 1): # "Presence of argument 1" test
        asm_in = sys.argv[1]
        if os.path.exists(asm_in): # "Presence of the file" test
            if(".asm" in asm_in): # "Recognition as .asm" test
                print(f"Detected file {asm_in}. Processing ... ")
                return asm_in               
            else:
                print(f"The file '{asm_in}' is not recognized as an assembly file.")                
                return False
        else:
            print(f"The file '{asm_in}' is not in the working directory.")
            return False
    else:    
        print("Operand assembly file name not provided.")
        return False
#___________________________ Function : FILTERING OUT MULTI-LINE COMMENTS ______________________________    
def filter_mltln_cmts(prog_asm):
    comment_start = '/*'
    comment_end = '*/'
    no_mltln_asm = progname + '_nml.asm'
    ignore = False
    first_line = True
    
    with open(prog_asm, 'r') as input_file, open(no_mltln_asm, 'w') as output_file:
        for line in input_file:    
            if(not first_line):    
                output_file.write('\n') # If there's an UPCOMING LINE from input file, allow for NEWLINE in the output file. 
            words = line.split()    # THE SEARCH FOR MULTILINE COMMENT BOOKENDS BEGINS. 
            for word in words:
                if(word == comment_start):
                    ignore = True
                    continue
                elif(word == comment_end):
                    ignore = False
                    continue
                elif(not ignore):
                    output_file.write(word)
            first_line = False 
#___________________________ Function : FILTERING OUT SINGLE-LINE COMMENTS _____________________________    
def filter_ln_cmts(asm_in):
    with open(asm_in, 'w') as file:
        None

def filter_comments(asm_in):
    filter_mltln_cmts(asm_in)
    filter_ln_cmts(asm_in)
#_______________________________ Function : CREATING THE SYMBOL TABLE __________________________________    
def make_symtable():
    print("Forgoing the creation of the symbol table ...")
#__________________________________ Function : CREATING .HACK FILE _____________________________________
def make_hackfile(asm_in):
    outfile = progname + ".hack"
    print("Creating", outfile, "...")
    with open(outfile, 'w') as file:
        None
    return outfile
############################################ Script body : #############################################
if(prog_asm := is_arg_good()):               # arg check
    progname, the_rest = prog_asm.split('.') # extracting the generic program name 
    filter_comments(prog_asm)                # comment filtration
    # building symbol table 
    
    #hack_out = make_hackfile(asm_in) # creating .hack file
    #__________________________________________________________________________________________________
    # Clean-up : 
    #os.remove(hack_out)
    os.remove(progname + '_nml.asm')
#######################################################################################################    

'''
- init indep. SYMTBLMGR(.py)
  - build     SYM.TABLE	w/ pre-defs
    as a dict 
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
