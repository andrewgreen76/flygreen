#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void sort(int * );
int get_start_i(int * , int , int * );
void scan_down(int * , int * , int , int * );
void scan_up(int * , int * , int , int * );

///////////////////////////////////////////////////////////////////////////
int main(int argc, char *argv[])
{
  int locs[10] = {0,0,0,0,0 , 0,0,0,0,0};
  int start_sector = 10;
  int start_i = 0;
  int total_mvmt = 0;
    
  printf("Enter disk locations to service: ");
  for(int i=0 ; i<10 ; i++){
    scanf("%d" , &(locs[i]) );
  }

  sort(locs);
  //=======================================================
  start_i = get_start_i(locs, start_sector , &total_mvmt);
  scan_down(locs , &start_sector , start_i , &total_mvmt);
  scan_up(locs , &start_sector , start_i , &total_mvmt);
  //=======================================================
  
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
int get_start_i(int * locs , int at_sector , int * tmv){
  
  if(at_sector < locs[0]) {
    *tmv = at_sector;
    return 0; 
  }
  
  int i=0;
  while( !( i<10 && at_sector>=locs[i] ) )  i++;
  return i;
}
///////////////////////////////////////////////////////////////////////////
void scan_down(int * locs , int * at_sector, int i , int * tmv){

  while(i > 0){
    i--;
    *tmv += abs(*at_sector - locs[i]); // added to mvmt dist 
    *at_sector = locs[i]; // rem new sector 
    
    fflush(stdout);
    printf("Sector %d\n" , locs[i]);
  }
  /*** i = 0 ************************************************/
  tmv += locs[0]; // from sector 1 to sector 0
  at_sector = 0; 
}
///////////////////////////////////////////////////////////////////////////
void scan_up(int * locs , int * at_sector, int i , int * tmv){
  
  for( ; i<10 ; i++){    
    *tmv += abs(*at_sector - locs[i]);
    *at_sector = locs[i];
    
    fflush(stdout);
    printf("Sector %d\n" , locs[i]);
  }    
}
///////////////////////////////////////////////////////////////////////////
