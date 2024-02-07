#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void sort(int * );
void scan_down(int * , int , int * );
void scan_up(int * );

///////////////////////////////////////////////////////////////////////////
int main(int argc, char *argv[])
{
  int locs[10] = {0,0,0,0,0 , 0,0,0,0,0};
  int at_sector = 10;
  int total_mvmt = 0;
    
  printf("Enter disk locations to service: ");

  for(int i=0 ; i<10 ; i++){
    scanf("%d" , &(locs[i]) );
  }

  sort(locs);
  //==============================
  scan_down(locs , at_sector , &total_mvmt);
  scan_up(locs , &total_mvmt);
  //==============================

  
  printf("Total Disk Head Movement: %d" , total_mvmt);
  
  printf("\n");
  return 0;
}

///////////////////////////////////////////////////////////////////////////
void sort(int * locs){
  
  for(int i=0 ; i<10 ; i++){
    for(int j=0 ; j<9 ; j++){
      if( locs[j]>locs[j+1] ) locs[j] ^= locs[j+1] ^= locs[j] ^= locs[j+1];
    }
  }
}
///////////////////////////////////////////////////////////////////////////
void scan_down(int * locs , int at_sector, int * tmv){

  int start_i = get_start_i(locs);
  
  for(int i=0 ; i<10 ; i++){
    fflush(stdout);
    printf("Sector %d\n" , locs[i]);
    
    total_mvmt += abs(at_sector - locs[i]);
    at_sector = locs[i];
  }  
}
///////////////////////////////////////////////////////////////////////////
void scan_up(int * locs , int * tmv){
}
///////////////////////////////////////////////////////////////////////////
