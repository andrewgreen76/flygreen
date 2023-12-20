#include <stdio.h>

int main(int argc , char * argv[]){
        int n; // number of processes
        int execution_time[100], waiting_time[100], turnaround_time[100], process_id[100];
        float total_waiting_time = 0, total_turnaround_time = 0;

        printf("Enter the number of processes: ");
        scanf("%d", &n);

        for(int i = 0; i < n; i++) {
            printf("Enter execution time for process %d: ", i+1);
            scanf("%d", &execution_time[i]);
            process_id[i] = i+1;
        }

        
}
