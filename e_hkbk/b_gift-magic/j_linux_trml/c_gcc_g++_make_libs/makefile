# Define variables
CC = gcc
CFLAGS = -Wall
SOURCE = myprogram.c
OUTPUT = myprogram

# Default target
all: $(OUTPUT)

# Compile and link the program
$(OUTPUT): $(SOURCE)
	$(CC) $(CFLAGS) -o $(OUTPUT) $(SOURCE)

# Clean up object files and the executable
clean:
	rm -f $(OUTPUT)
