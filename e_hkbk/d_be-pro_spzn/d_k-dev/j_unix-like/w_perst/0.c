#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int main(int argc, char *argv[])
{
  int locs[10] = {0,0,0,0,0 , 0,0,0,0,0};
  int at_sector = 10;
  int total_mvmt = 0; 
  
  printf("Enter disk locations to service: ");

  for(int i=0 ; i<10 ; i++){
    scanf("%d" , &(locs[i]) );
  }
  
  for(int i=0 ; i<10 ; i++){
    printf("Sector %d\n" , locs[i]);
    total_mvmt += abs(at_sector - locs[i]);
    at_sector = locs[i];
  }

  printf("Total Disk Head Movement: %d" , total_mvmt);
  
  printf("\n");
  return 0;
}
