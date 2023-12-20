#include <stdio.h>

int main(int argc , char * argv[]) {
        // INIT JOBS : 
        int n; // number of processes
        int duration[100], waiting_time[100], turnaround_time[100], total_turnaround_time = 0 , 
                total_waiting_time = 0;

        // PROMPT : 
        printf("Enter the number of processes: ");
        scanf("%d", &n);

        // ASSIGN DURATIONS TO JOBS : 
        for(int i = 0; i < n; i++) {
            printf("Enter duration for process %d: ", i+1);
            scanf("%d", &duration[i]);
        }

        // 1ST JOB WILL START IMMEDIATELY : 
        waiting_time[0] = 0;
        turnaround_time[0] = duration[0];
        // COMPUTE THE TIMES FOR EVERY JOBS : 
        for(int i = 1; i < n; i++) {
            waiting_time[i] = duration[i-1] + waiting_time[i-1];
            turnaround_time[i] = duration[i] + waiting_time[i];
        }

        // COMPUTING THE TOTALS : 
        for(int i = 0; i < n; i++) {
            total_waiting_time += waiting_time[i];
            total_turnaround_time += turnaround_time[i];
        }

        // DISPLAY STATS PER JOB : 
        printf("Process\tDuration\tWaiting Time\tTurnaround Time\n");
        for(int i = 0; i < n; i++) {
            printf("%d\t%d\t\t%d\t\t%d\n", i+1, duration[i], waiting_time[i], turnaround_time[i]);
        }

        printf("Average Waiting Time: %.2lf\n", (double)total_waiting_time / (double)n );
        printf("Average Turnaround Time: %.2lf\n", (double)total_turnaround_time / (double)n );

        return 0;
}
