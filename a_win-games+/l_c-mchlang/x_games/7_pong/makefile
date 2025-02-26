CC = gcc
CFLAGS = -Wall -Wextra -O2
TARGET = ./bin/pong.bin 
SRC = ./src/pong.c
LFLAGS = -lm
# OBJECTS =
# INCLUDES = -I./

all: $(TARGET)

$(TARGET): $(SRC)
	$(CC) $(CFLAGS) -o $(TARGET) $(SRC) $(LFLAGS)

clean:
	rm -f $(TARGET)
