# Define variables
CC = gcc
CFLAGS = -Wall -Wextra -std=c11
LDFLAGS = 
SRC = src.c
DEPS = queue.c
HEADERS = queue.h 
TARGET = run

# Default target
all: $(TARGET)

# Compile and link the program
$(TARGET): $(SRC) $(DEPS) $(HEADERS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SRC) $(DEPS) 

# Clean up object files and the executable
clean:
	rm -f $(TARGET)
