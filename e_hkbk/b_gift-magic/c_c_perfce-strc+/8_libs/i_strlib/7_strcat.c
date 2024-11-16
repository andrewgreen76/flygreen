#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

int main () {
   printf("\n");

   char *txt;

   txt = (char *) malloc(6);
   strcpy(txt, "Hello");
   printf("String: %s,  Address: %lu\n", txt, (uint64_t) txt);

   txt = (char *) realloc(txt, 25);
   strcat(txt, " World");
   printf("String: %s,  Address: %lu\n", txt, (uint64_t) txt);

   free(txt);
   printf("\n");
}
