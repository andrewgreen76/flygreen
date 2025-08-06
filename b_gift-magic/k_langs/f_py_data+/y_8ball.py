import math
import random

######################################################################################################

# PRINTING 
print("My name is Kid Rock!")

# STORING
answers = ["You give it meaning." ,
	   "It depends." ,
	   "Try every door ... or every door that opens." ,
	   "Divide your problem space in two until there is nothing left to divide." ,
	   "Do you think you can think of a better option?" ,
	   "Simply create something that either (a) emphasizes your strengths or (b) benefits the world." ,
	   "Is this a question regarding your \"lawful wife\" or your \"mistress\"?" ,
	   "You figure it out now since it's not OK to stay in one place for too long."
	   ]

# arithmetic evaluation 
print( 2+3 )

# logic evaluation
print( not(1) )

# random number generation
rand = random.randint( 0 , len(answers)-1 )
print( answers[rand] )
