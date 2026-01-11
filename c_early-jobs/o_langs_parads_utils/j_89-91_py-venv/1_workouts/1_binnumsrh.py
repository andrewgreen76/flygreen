
import sys

#####################################################################################
inqcnt = 0
# => guess space : [1-3] 
u = 100
l = 0
#
a = 17
#####################################################################################
def delay():
    t=0
    while t<40000000:
        t += 1
#####################################################################################
def gencase(u,l,ref):
    print (f"The guess becomes the REFERENCE : {ref}")

    print ("Let's try again")
    if a>ref:
        print ("UPPER HALF CHOSEN")
        half( u , ref )
    else:
        print ("LOWER HALF CHOSEN")
        half( ref , l )
#####################################################################################
def half( u , l ):
    global inqcnt    # Gotta specify that you are using that global inquiry count.
    inqcnt += 1

    print (f"\nAnswer: {a}")
    print ("|")
    print (f"Inquiry count : {inqcnt}")
    # Damage control : 
    if inqcnt==10:
        print("Guess count exceeded.")
        sys.exit()
    else:
        pass

    # Debugging : 
    print (f"Upper bound : {u}")
    print (f"Lower bound : {l}")

    # Thinking and guessing : 
    delay()
    g=((u-l)//2)+l
    print(f"g = ( ({u}-{l})//2 ) + {l}")
    print (f">>> Guess: {g}")
    delay()

    # check the special case
    if a==g:
        print (f"Success! Number of tries : {inqcnt}\n")
    else:
        print(f"It's not {g}. Subdivide.")
        gencase(u,l,g)
#####################################################################################

        
half( u , l )
