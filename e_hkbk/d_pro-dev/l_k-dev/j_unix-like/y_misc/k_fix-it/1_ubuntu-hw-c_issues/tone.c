
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

void playTone(unsigned int frequency) {
    char command[100];
    sprintf(command, "beep -f %u -l 1000", frequency);
    system(command);
}

int main() {
    playTone(440);  // Play a 440Hz tone for 1 second
    return 0;
}

