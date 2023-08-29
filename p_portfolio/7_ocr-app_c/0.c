#include <stdio.h>
#include <stdlib.h>

#define INITIAL_CAPACITY 10

typedef struct {
    char *data;
    size_t capacity;
    size_t length;
} DynamicString;

void initDynamicString(DynamicString *str) {
    str->data = malloc(INITIAL_CAPACITY);
    str->capacity = str->data ? INITIAL_CAPACITY : 0;
    str->length = 0;
}

void appendToDynamicString(DynamicString *str, char c) {
    if (str->length + 1 >= str->capacity) {
        str->capacity *= 2; // Double the capacity
        str->data = realloc(str->data, str->capacity);
    }

    str->data[str->length++] = c;
}

int main() {
    DynamicString inputString;
    initDynamicString(&inputString);

    printf("Enter a string: ");
    int c;
    while ((c = getchar()) != '\n' && c != EOF) {
        appendToDynamicString(&inputString, c);
    }

    // Print the input string
    printf("You entered: %s\n", inputString.data);

    // Clean up
    free(inputString.data);

    return 0;
}
