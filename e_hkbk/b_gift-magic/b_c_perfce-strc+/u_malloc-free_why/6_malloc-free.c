#include <stdio.h>
#include <stdlib.h>

int main() {
    int size;
    int* arr;

    printf("Enter the size of the array: ");
    scanf("%d", &size);

    arr = (int*)malloc(size * sizeof(int));  // Dynamic memory allocation

    if (arr != NULL) {
        printf("Dynamic memory allocation succeeded.\n");

        // Use the allocated memory

        // ...

        free(arr);  // Free the allocated memory when no longer needed
        printf("Dynamic memory deallocation completed.\n");
    } else {
        printf("Dynamic memory allocation failed.\n");
    }

    return 0;
}
