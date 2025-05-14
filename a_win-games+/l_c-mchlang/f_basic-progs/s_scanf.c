
/* Personally , I would not use scanf() because it breaks up the entire input string
   (incl. whitespaces but not including the end-of-string delimiter) into individual
   words (sub-strings) at the space characters. 
    - Space characters, tabs, and other whitespace characters are treated as delimiters.
    - The tokens are populated as input for the user across consecutive prompts. 
    - This can be worked around with a scanset [^\n] , but I'd have to think that there
      has to be a solution - a function - more elegant than a clumsy adjustment. Maybe
      something like fgets(). 
    - The individual words in a string are called tokens. 
*/

#include <stdio.h>

int main() {
    char inputString[100]; // Assuming a maximum string length of 99 characters

    printf("Enter a string: ");
    if (scanf("%s", inputString) == 1) {
        // Successfully read the string
        printf("You entered: %s\n", inputString);
    } else {
        // Handle input error
        printf("Error reading input.\n");
    }

    return 0;
}
