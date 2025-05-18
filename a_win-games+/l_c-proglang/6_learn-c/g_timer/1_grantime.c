#include <stdio.h>
#include <time.h>

int main() {
  struct timespec ts;
  char buffer[12]; // Buffer for HH:MM:SS.mmm (11 chars + null terminator)

  // Get current time with nanosecond precision
  clock_gettime(CLOCK_REALTIME, &ts);

  // Convert to local time for HH:MM:SS
  struct tm *local_time = localtime(&ts.tv_sec);
  strftime(buffer, sizeof(buffer), "%H:%M:%S", local_time);

  // Append milliseconds
  snprintf(buffer + 8, 5, ".%03ld", ts.tv_nsec / 1000000); // Size 5 for .mmm\0

  printf("Current time: %s\n", buffer);
  return 0;
}
