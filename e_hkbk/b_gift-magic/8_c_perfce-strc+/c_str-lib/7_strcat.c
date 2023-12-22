#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main () {
   printf("\n");

   char *txt;

   txt = (char *) malloc(6);
   strcpy(txt, "Hello");
   printf("String: %s,  Address: %u\n", txt, txt);

   txt = (char *) realloc(txt, 25);
   strcat(txt, " World");
   printf("String: %s,  Address: %u\n", txt, txt);

   printf("\n");
}
