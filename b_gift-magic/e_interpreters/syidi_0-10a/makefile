CC = gcc
CFLAGS = -O0 #-Wall -Wextra
LFLAGS = -fno-lto
SRC = syidi.c repl.c screxec.c cmdproc.c
OUT = syidi

$(OUT): $(SRC)
	$(CC) $(CFLAGS) $(LFLAGS) -o $(OUT) $(SRC)

clean:
	rm $(OUT)
