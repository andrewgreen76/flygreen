#!/usr/bin/env python3
print()
print("Starting the Hack Assembler ...")

print("Importing the symbol table manager class ...")
from symtblmgr import SymbolTableManager  
print("Symbol table manager class imported.")

print("Importing the parser class ...")
from parser import Parser
print("Parser class imported.")

print("Importing the translator class ...")
from translator import Translator
print("Translator class imported.")

import sys
import os

progname = "prog"

#_______________________________ Function : PARSE-TRANSLATE ROUTINE ____________________________________
def parse_trans_loop():

    is_first_instr = True

    print("Parsing through and translating instructions ...")
    # Translate to .hack file on-the-fly : 
    with open(progname + '_pure.asm', 'r') as input_file, open(progname + '.hack', 'w') as output_file:
        for instr in input_file:
            prs = Parser()
            trans = Translator()
            instr = instr.strip()
            
            if(is_first_instr):
                is_first_instr = False
            else:
                output_file.write('\n')

            output_file.write(trans.get_bin_instr(prs.get_fields(instr)))
                
#_____________________________________ Function : RESULT DISPLAY _______________________________________
def show_content(filename):

    print(f"Displaying contents of the file '{filename}' ...")
    
    with open(filename, 'r') as file:
        for line in file:
            print(line, end='')  # Print each line without adding extra newline

#_________________________________ Function : FILTERING OUT COMMENTS ___________________________________    
def filter_ln_cmts(prog_asm):

    first_instr = True
    print(f"Generating non-code filtration files for program \'{progname}\' ...")

    # Filtering out whole-line comments : 
    with open(progname + '.asm', 'r') as input_file, open(progname + '_nsl.asm', 'w') as output_file:
        for line in input_file:
            if(line[0]=='D' or line[0]=='M' or line[0]=='A' or line[0]=='0' or line[0]=='@'):
                if(first_instr):
                    first_instr = False
                else:
                    output_file.write('\n')
                output_file.write(line.strip())

    
    # Filtering out inline comments : 
    first_instr = True
    with open(progname + '_nsl.asm', 'r') as input_file, open(progname + '_pure.asm', 'w') as output_file:
        for line in input_file:
            if(first_instr):
                first_instr = False
            else:
                output_file.write('\n')
            substrings = line.split('//')
            instruction = substrings[0].strip()
            output_file.write(instruction)
            first_instr = False

def filter_comments(prog_asm):
    #filter_mltln_cmts(prog_asm)
    filter_ln_cmts(prog_asm)
#_______________________________ Function : CREATING THE SYMBOL TABLE __________________________________    

def make_symtable():
    print("Forgoing the creation of the symbol table ...")

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
    
############################################ Script body : #############################################
if(prog_asm := is_arg_good()):               # arg check
    progname, the_rest = prog_asm.split('.') # extracting the generic program name 
    filter_comments(prog_asm)                # comment filtration
    parse_trans_loop()
    #__________________________________________________________________________________________________

    # Clean-up :
    print(f"File {progname}.hack generated.")
    print("Removing auxiliary files ...")
    os.remove(progname + '_nsl.asm')
    os.remove(progname + '_pure.asm')
    show_content(progname + '.hack')    
    #os.remove(progname + '.hack')
#######################################################################################################    

'''
- init indep. SYMTBLMGR(.py)
  - build     SYM.TABLE	w/ pre-defs
    as a dict 
'''

'''
- pass_for_LABELS (decls)
  > givenname.hack
|
- pass_for_vars ()
  > givenname.hack
'''

'''
- clean-up :
  - delete sym.table
'''
