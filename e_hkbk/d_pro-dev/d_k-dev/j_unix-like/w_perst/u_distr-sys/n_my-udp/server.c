#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>
#include <netinet/in.h>
#include <assert.h>

#define SERVER_IP "192.168.1.119"
#define SERVER_PORT 50000
#define BUFFER_SIZE 1024

int main() {
    int sd = socket(AF_INET, SOCK_DGRAM, 0);
    assert(sd > -1);

    struct sockaddr_in serverAddr;
    memset(&serverAddr, 0, sizeof(serverAddr));
    serverAddr.sin_family = AF_INET;
    serverAddr.sin_port = htons(SERVER_PORT);
    serverAddr.sin_addr.s_addr = INADDR_ANY;

    // Bind the socket to the server address
    assert(bind(sd, (struct sockaddr*)&serverAddr, sizeof(serverAddr)) != -1);

    ssize_t bytesRead = 0;

    while (bytesRead <= 0) {
        ///////////////////////////// Receive data //////////////////////////////
        char message[BUFFER_SIZE];
        struct sockaddr_in clientAddr;
        socklen_t clientAddrLen = sizeof(clientAddr);
        bytesRead = recvfrom(sd, message, sizeof(message), 0, (struct sockaddr*)&clientAddr, &clientAddrLen);

        if (bytesRead > 0) {
            message[bytesRead] = '\0';  // Null-terminate the received data
            printf("Client Says: %s", message);

            /////////////////////////////// Send data ///////////////////////////////
            sprintf(message, "I am fine, thank you.\n");
            sendto(sd, message, strlen(message), 0,
                   (struct sockaddr*)&clientAddr, sizeof(clientAddr));

            printf("Response sent.\n");
        }
    }

    close(sd);
    return 0;
}

