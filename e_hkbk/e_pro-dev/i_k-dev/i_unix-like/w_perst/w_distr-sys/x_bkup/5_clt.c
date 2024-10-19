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
  int sd = UDP_Open(20000);
  struct sockaddr_in addrSnd, addrRcv;
  int rc = UDP_FillSockAddr(&addrSnd, "coconut-insect.codio.io", 10000);
  char message[BUFFER_SIZE];
  sprintf(message, "Hello, how are you?\n");
  rc = UDP_Write(sd, &addrSnd, message, BUFFER_SIZE);

  printf("Hello message sent.\n");

  if (rc > 0) {
    int rc = UDP_Read(sd, &addrRcv, message, BUFFER_SIZE);
    printf("Server Says: %s" , message);
  }
  return 0;
}
