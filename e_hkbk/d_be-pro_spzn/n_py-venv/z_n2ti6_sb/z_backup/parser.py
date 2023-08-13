#!/usr/bin/env python3

class Parser:

    def __init__(self):
        
        # An instance of this class will produce : @a_val
        self.a_sym = ''
        self.a_vstr = ''
        self.comp = ''
        self.dest = ''
        self.jump = ''
    #######################################################################
    def get_fields(self, instr):

        # A-instr : 
        if(instr[0] == '@'):
            self.a_sym = '@'
            self.a_vstr = instr[1:]
        # C-instr with dest=comp : 
        elif('=' in instr):
            fields = instr.split('=')
            self.dest = fields[0]
            self.comp = fields[1]
        # C-instr with comp;jump
        elif(';' in instr):
            fields = instr.split(';')
            self.comp = fields[0]
            self.jump = fields[1]
        # Something else, probably a bad instruction : 
        else:
            print("Invalid instruction:", instr)

        return [self.a_sym, self.a_vstr, self.comp, self.dest, self.jump]
    #######################################################################
    def get_a_val():
        return self.a_val_str
    #######################################################################
    def get_comp():
        return self.comp
    #######################################################################
    def get_dest():
        return self.dest
    #######################################################################
    def get_jump():
        return self.jump
