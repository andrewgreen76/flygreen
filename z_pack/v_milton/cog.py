
#######################################################################################
# Using words or numbers to represent qualities.
#######################################################################################
# LET'S COUPLE (multiply) values to produce an ethically correct judgment for Milton.
#####################################################
'''
JOHN __ had AN ARGUMENT __ with PAUL.
John - subject
an argument - direct object
Paul - indirect object
'''
#####################################################
input_objects = {
    "I": 1,
    "you": 1,
    "we": 0,
    "they": 0,
    "he": 0,
    "she": 0,
    "it": 0
}
#####################################################
input_actions = {
    "love": 1,
    "hate": -1,

    "heal": 1,
    "kill": -1,

    "create": 1,
    "destroy": -1,

    "want": 1,
    "try": 1,
    "play": 1,
    "give": 1,
    "provide": 1,
    "dream": 1,
    "be aware of": 1    
}
#####################################################
input_qualities = {
    #depends: 0

    "good": 1,
    "bad": -1,
    "malignant": -1,

    "works": 1,
    "does_not_work": -1,

    "safe": 1,
    "not_safe": -1,
    
    "should_be": 1,
    "should_not_be": -1,
    
    "benefit": 1,
    "harm": -1,
    "evil": -1,

    "resourceful": 1,
    "not_resourceful": -1,

    "pleasure": 1, #depends,
    "peace": 1, #depends,
    "indifference": 0, #depends,
    "pain": -1,

    "satisfaction": 1,
    "disappointment": -1,
    "frustration": -1,

    "productive": 1,
    "fruitful": 1,
    "unproductive": -1,

    "love": 1,
    "hate": -1,

    "trust": 0
}
#####################################################
output_qualities = {
    1: "good",
    -1: "bad"
    # 0: "It depends."
    # 1: "It's unclear." # "I'm not sure."
    # 5: "Should I be worried?"
    # 9: "I don't know how to respond to that."
}
#####################################################

def processing(user_input):
    ideas = user_input.split()
    for idea in ideas:
        print(idea)
    #pass
