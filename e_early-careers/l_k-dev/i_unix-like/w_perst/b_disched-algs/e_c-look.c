/* Enter disk locations to service:
Sector 36
Sector 52
Sector 54
Sector 72
Sector 95
Sector 112
Sector 145
Sector 164
Sector 5
Sector 8
Total Disk Head Movement: 316 
36 52 54 72 95 112 145 164 5 8
*/

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

void sort(int * );
int get_start_i(int * , int , int * );
void scan_uplim(int * , int * , int , int * );
void scan_drop(int * , int * , int * );
void scan_close(int * , int * , int , int * );

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
  //==============================================================
  start_i = get_start_i(locs, start_sector , &total_mvmt);
  scan_uplim(locs , &start_sector , start_i , &total_mvmt);
  scan_drop(locs , &start_sector , &total_mvmt);
  scan_close(locs , &start_sector , start_i , &total_mvmt);
  //==============================================================
  
  printf("Total Disk Head Movement: %d" , total_mvmt);
  
  printf("\n");
  return 0;
}
///////////////////////////////////////////////////////////////////////////
void scan_uplim(int * locs , int * at_sector, int i , int * tmv){
  
  for( ; i<10 ; i++){    
    *tmv += abs(*at_sector - locs[i]);
    *at_sector = locs[i];
    
    fflush(stdout);
    printf("Sector %d\n" , locs[i]);
  }    
}
///////////////////////////////////////////////////////////////////////////
void scan_drop(int * locs , int * at_sector, int * tmv){

  *tmv += abs(*at_sector - locs[0]); // added to mvmt dist 
  *at_sector = locs[0]; // rem new sector 
    
  fflush(stdout);
  printf("Sector %d\n" , locs[0]);
}
///////////////////////////////////////////////////////////////////////////
void scan_close(int * locs , int * at_sector, int start_i , int * tmv){

  int i=1;
  //*at_sector = locs[1]; // rem new sector 

  while( i != start_i ){
    *tmv += abs(*at_sector - locs[i]); // added to mvmt dist 
    *at_sector = locs[i]; // rem new sector 
    
    fflush(stdout);
    printf("Sector %d\n" , locs[i]);
    
    i++;
  }
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
  while( i<10 && at_sector>=locs[i] )  i++;
  return i;
}
///////////////////////////////////////////////////////////////////////////
