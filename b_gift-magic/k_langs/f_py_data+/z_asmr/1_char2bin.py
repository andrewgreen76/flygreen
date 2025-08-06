tapename = "0_tape.txt"

#######################################################################################

with open( tapename , 'r' ) as tape :
    while( not( (char := tape.read(1))=='' ) ) :     # parse the tape
        print( bin(ord(char))[2:].zfill(8) )         # convert ASCII char to bin 
