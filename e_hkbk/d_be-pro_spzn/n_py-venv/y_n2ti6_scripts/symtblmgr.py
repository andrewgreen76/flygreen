#!/usr/bin/env python3

class SymbolTableManager:

    def __init__(self):
        # Build the symble table : 
        self.table = {
            'R0':'0', 'R1':'1', 'R2':'2', 'R3':'3',
            'R4':'4', 'R5':'5', 'R6':'6', 'R7':'7',
            'R8':'8', 'R9':'9', 'R10':'10', 'R11':'11',
            'R12':'12', 'R13':'13', 'R14':'14', 'R15':'15',
            'SCREEN':'16384', 'KBD':'24576',
            'SP':'0', 'LCL':'1', 'ARG':'2', 'THIS':'3', 'THAT':'4'
        }
    #############################################################################
    def map_labels(self, progname):

        is_first_line = True

        print("Searching for labels to add to the symbol table ...")
        with open('2_' + progname + '_pure.asm', 'r') as infile, open('3_' + progname + '_nodecl.asm', 'w') as outfile:
            index = 0
            for line in infile:
                
                stripped_line = line.strip()

                # Declaration detected.
                if( '(' in stripped_line):      
                    decl = stripped_line.replace('(', '')
                    decl = decl.replace(')', '')
                    if(decl not in list(self.table)):
                        self.table[decl] = str(index) # Add new label, index of following command to the table.
                                                      # Do not increment index, just move on to the actual instruction.

                # Otherwise, it's an actual instruction, ...
                else:
                    if(is_first_line):    # Dodging the newline bullets ... again. 
                        is_first_line = False
                    else:
                        outfile.write('\n')
                    outfile.write(stripped_line)    
                    index += 1             # ... and increment the instruction counter. 
    #############################################################################
    def map_vars(self, progname):

        is_first_instr = True
        
        print("Searching for variables to add to the symbol table ...")
        with open('3_' + progname + '_nodecl.asm', 'r') as infile:
            avail_index = 16    # First avail RAM address for a variable. 
            for instr in infile:

                if(is_first_instr):    # Dodging the newline and indent bullets ... again. 
                    is_first_instr = False
                instr = instr.strip()
        
                if('@' in instr):
                    var = instr[1:]

                    if(var not in list(self.table) and not var.isnumeric()):    # If the encountered var is new,..
                        self.table[var] = str(avail_index)   # ..add to the table. 
                        avail_index += 1                     # Mark next avail. RAM address. 
