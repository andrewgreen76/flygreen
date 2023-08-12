#!/usr/bin/env python3

at = '@'
a_val = ''
comp = ''
dest = ''
jump = ''

def get_fields(instr):

    global a_val, comp, dest, jump

    # A-instr : 
    if(instr[0] == at):
        a_val = instr.split('@')[1]
    # C-instr with dest=comp : 
    elif('=' in instr):
        fields = instr.split('=')
        dest = fields[0]
        comp = fields[1]
        jump = ''
    # C-instr with comp;jump
    elif(';' in instr):
        fields = instr.split(';')
        dest = ''
        comp = fields[0]
        jump = fields[1]
    else:
        print("Invalid instruction:", instr)

def get_a_val():
    global a_val
    return a_val

def get_comp():
    global comp
    return comp

def get_dest():
    global dest
    return dest

def get_jump():
    global jump
    return jump
