#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>

#define PORT	 8080
#define BUFFER_SIZE 1024


int main() {
  int sd = UDP_Open(10000);
  assert(sd > -1);
  while (1) {
    struct sockaddr_in addr;
    char message[BUFFER_SIZE];
    int rc = UDP_Read(sd, &addr, message, BUFFER_SIZE);
    printf("Client Says: %s" , message);
    if (rc > 0) {
      char reply[BUFFER_SIZE];
      sprintf(reply, "I am fine, thank you.");
      rc = UDP_Write(sd, &addr, reply, BUFFER_SIZE);
      printf("Response sent.");
    }
  }
  return 0;
}
