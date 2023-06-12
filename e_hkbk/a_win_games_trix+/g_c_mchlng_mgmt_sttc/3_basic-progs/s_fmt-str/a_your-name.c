#include <stdio.h>

int main() {
    char username[20];
    printf("Enter your username: ");
    scanf("%s", username);

    printf("Welcome, ");
    printf(username); // Vulnerable line
    printf("!\n");

    return 0;
}
