#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>

#define SERVER_IP "192.168.10.226"  // "127.0.0.1"
#define SERVER_PORT	 8080
#define BUFFER_SIZE 1024


int main() {

  int sd = socket(AF_INET, SOCK_DGRAM, 0);  
  //assert(sd > -1);

  ////////////////// Set up the server address structure //////////////////
  struct sockaddr_in serverAddr;
  memset(&serverAddr, 0, sizeof(serverAddr));
  serverAddr.sin_family = AF_INET;
  serverAddr.sin_port = htons(SERVER_PORT);
  serverAddr.sin_addr.s_addr = INADDR_ANY;
  // Bind the socket to the server address
  bind(sd, (struct sockaddr*)&serverAddr, sizeof(serverAddr));

  while (1) {
    ///////////////////////////// Receive data //////////////////////////////
    char message[BUFFER_SIZE];
    struct sockaddr_in clientAddr;
    socklen_t clientAddrLen = sizeof(clientAddr);
    ssize_t bytesRead = recvfrom(sd, message, sizeof(message), 0,
                                 (struct sockaddr*)&clientAddr, &clientAddrLen);
    
    message[bytesRead] = '\0';  // Null-terminate the received data
    printf("Client Says: %s" , message);
    /////////////////////////////// Send data ///////////////////////////////
    if (bytesRead > 0) {
      sprintf(message, "I am fine, thank you.");

      struct sockaddr_in clientAddr;
      memset(&clientAddr, 0, sizeof(clientAddr));
      clientAddr.sin_family = AF_INET;
      clientAddr.sin_port = htons(SERVER_PORT);  // client port
      clientAddr.sin_addr.s_addr = inet_addr(SERVER_IP);  // client IP address
      sendto(sd, message, strlen(message), 0, 
            (struct sockaddr*)&clientAddr, sizeof(clientAddr));

      printf("Response sent.");
    }
  }

  close(sd);
  return 0;
}
