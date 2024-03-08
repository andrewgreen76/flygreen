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
def parse_trans_loop(sym_table):

    is_first_instr = True

    print("Parsing through and translating instructions ...")
    # Translate to .hack file on-the-fly : 
    with open('3_' + progname + '_nodecl.asm', 'r') as input_file, open(progname + '.hack', 'w') as output_file:
        for instr in input_file:
            prs = Parser()
            trans = Translator()
            instr = instr.strip()
            
            if(is_first_instr):
                is_first_instr = False
            else:
                output_file.write('\n')

            
            output_file.write(trans.get_bin_instr(prs.get_fields(instr, sym_table)))
                
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
    with open(progname + '.asm', 'r') as input_file, open('1_' + progname + '_nsl.asm', 'w') as output_file:
        for line in input_file:
            subject = line.strip()

            if(subject != ''):
                #print(f"Subject: {subject}")
                if(subject[0]=='D' or subject[0]=='M' or subject[0]=='A' or subject[0]=='0' or subject[0]=='@' or subject[0]=='('):

                    if(first_instr):
                        first_instr = False
                    else:
                        output_file.write('\n')
                    
                    output_file.write(subject)
    
    # Filtering out inline comments : 
    first_instr = True
    with open('1_' + progname + '_nsl.asm', 'r') as input_file, open('2_' + progname + '_pure.asm', 'w') as output_file:
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

    symgr = SymbolTableManager() # Symbol table built with pre-defined elements.
    symgr.map_labels(progname)
    symgr.map_vars(progname)
    parse_trans_loop(symgr.table)
    #__________________________________________________________________________________________________

    # Clean-up :
    print(f"File {progname}.hack generated.")
    #show_content(progname + '.hack')    

    print("Removing auxiliary files ...")
    os.remove('1_' + progname + '_nsl.asm')
    os.remove('2_' + progname + '_pure.asm')
    os.remove('3_' + progname + '_nodecl.asm')
    #os.remove(progname + '.hack')
    print("Clean-up completed.")
    
