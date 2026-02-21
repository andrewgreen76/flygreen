#include <stdio.h>

int main() {
    // Open the file for reading
    FILE *file = fopen("1_victim.txt", "r");
    if (file == NULL) {
        perror("Error opening file");
        return 1; // Return error
    }

    // Move the file position indicator to the desired byte/character
    if (fseek(file, 10, SEEK_SET) != 0) { // Move 10 bytes from the beginning
        perror("Error seeking in file");
        fclose(file);
        return 1; // Return error
    }

    // Get the current position (address) in the file
    long position = ftell(file);
    if (position == -1) {
        perror("Error getting file position");
        fclose(file);
        return 1; // Return error
    }

    // Output the address
    printf("Address of byte/character: %ld\n", position);

    // Close the file
    fclose(file);

    return 0; // Return success
}
