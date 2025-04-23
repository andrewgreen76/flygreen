CC = gcc
CFLAGS = -O0 #-Wall -Wextra
LFLAGS = -fno-lto
SRC = gin.c
OUT = gin

$(OUT): $(SRC)
	$(CC) $(CFLAGS) $(LFLAGS) -o $(OUT) $(SRC)

clean:
	rm $(OUT)
