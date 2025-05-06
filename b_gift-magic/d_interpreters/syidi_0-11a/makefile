CC = gcc
CFLAGS = -I./include -O0 #-Wall -Wextra
LFLAGS = -fno-lto
SRC = ./src/*
OUT = syidi

$(OUT): $(SRC)
	$(CC) $(CFLAGS) $(LFLAGS) -o $(OUT) $(SRC)

clean:
	rm $(OUT)
