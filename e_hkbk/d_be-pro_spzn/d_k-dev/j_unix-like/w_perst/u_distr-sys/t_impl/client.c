#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <assert.h>

//#define SERVER_IP "192.168.10.226"  // "127.0.0.1"
#define SERVER_IP "192.168.1.119" 
#define SERVER_PORT 50000
#define BUFFER_SIZE 1024

int main() {

  int sd = socket(AF_INET, SOCK_DGRAM, 0);
  assert(sd > -1);

  ////////////////// Set up the server address structure //////////////////
  struct sockaddr_in serverAddr;
  memset(&serverAddr, 0, sizeof(serverAddr));
  serverAddr.sin_family = AF_INET;
  serverAddr.sin_port = htons(SERVER_PORT);
  serverAddr.sin_addr.s_addr = inet_addr(SERVER_IP);

  /////////////////////////////// Send data ///////////////////////////////
  char message[BUFFER_SIZE];
  sprintf(message, "Hello, how are you?\n");
  ssize_t bytesSent = sendto(sd, message, strlen(message), 0,
                               (struct sockaddr*)&serverAddr, sizeof(serverAddr));

  printf("Hello message sent.\n");

  /////////////////////////////// Receive data ///////////////////////////////
  if (bytesSent > 0) {
    struct sockaddr_in senderAddr;
    socklen_t senderAddrLen = sizeof(senderAddr);
    ssize_t bytesRead = recvfrom(sd, message, sizeof(message), 0,
                                 (struct sockaddr*)&senderAddr, &senderAddrLen);

    message[bytesRead] = '\0';  // Null-terminate the received data
    printf("Server Says: %s" , message);
  }

  close(sd);
  return 0;
}
