CC = gcc
CFLAGS = -I./include/ -c -O0 #-Wall -Wextra
LFLAGS = -fno-lto
OBJ = ./build/pxlate.o 
OUT = ./bin/pxlate

build:
	mkdir -p build 

bin:
	mkdir -p bin

dirs: build bin

$(OUT): $(OBJ) | dirs 
	$(CC) $(LFLAGS) $(OBJ) -o $(OUT)

./build/pxlate.o: ./src/pxlate.c
	$(CC) $(CFLAGS) ./src/pxlate.c -o ./build/pxlate.o

clean:
	rm $(OUT) $(OBJ)
