
#___________________________ Function : FILTERING OUT MULTI-LINE COMMENTS ______________________________    
def filter_mltln_cmts(prog_asm):

    comment_start = '/*'
    comment_end = '*/'
    no_mltln_asm = progname + '_nml.asm'
    first_line = True
    ignore = False
    instr_found = False

    with open(prog_asm, 'r') as input_file, open(no_mltln_asm, 'w') as output_file:
        for line in input_file:
            if(not first_line):    
                output_file.write('\n') # If there's an UPCOMING LINE from input file, allow for NEWLINE in the output file.
            words = line.split('/*', 1)
            '''
            if(words[0]):
                #
            while(words[1]):
                if(not)
            '''
            #
            first_line = False            

    # '/*' and '*/' each can be a part of a word.  

