CC = gcc
CFLAGS = -Wall -Wextra -std=c11
LDFLAGS = -lpthread

SRC = prog.c
DEPS = 
HEADERS = 

# The target executable
TARGET = prog

all: $(TARGET)

$(TARGET): $(SRC) $(DEPS) $(HEADERS)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $(SRC) $(DEPS) -I.

.PHONY: clean

clean:
	rm -f $(TARGET)
