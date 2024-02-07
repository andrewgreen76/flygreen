#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void sort(int * locs);

int main(int argc, char *argv[])
{
  int locs[10] = {0,0,0,0,0 , 0,0,0,0,0};
  int at_sector = 10;
  int to_sector = 0;
  int total_mvmt = 0;
  
  total_mvmt = (at_sector - to_sector);
  at_sector = to_sector; 
  
  printf("Enter disk locations to service: ");

  for(int i=0 ; i<10 ; i++){
    scanf("%d" , &(locs[i]) );
  }

  sort(locs);
  
  for(int i=0 ; i<10 ; i++){
    fflush(stdout);
    printf("Sector %d\n" , locs[i]);
    total_mvmt += abs(at_sector - locs[i]);
    at_sector = locs[i];
  }

  printf("Total Disk Head Movement: %d" , total_mvmt);
  
  printf("\n");
  return 0;
}


void sort(int * locs){

  for(int i=0 ; i<10 ; i++){
    for(int j=0 ; j<9 ; j++){
      if( locs[j]>locs[j+1] ) locs[j] ^= locs[j+1] ^= locs[j] ^= locs[j+1];
    }
  }
}
