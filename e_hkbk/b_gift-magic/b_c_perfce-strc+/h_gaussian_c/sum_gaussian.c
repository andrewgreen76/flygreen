
#include <stdio.h>

//#################################################################
//######################### FUNCTIONS : ###########################
//#################################################################

size_t validate(size_t input){
  //
}

size_t sanitize(size_t input){
  //
}

size_t getval(){
  size_t retval;
  scanf("%zu" , &retval);
  validate(retval);
  sanitize(retval);
}

//#################################################################
//######################## MAIN LOGIC : ###########################
//#################################################################

void main(){
  printf("\n");
  
  printf("Type min of range: ");
  size_t min = get_valid_min();
  printf("\n");
  
  //smint max = get_valid_max();
}
