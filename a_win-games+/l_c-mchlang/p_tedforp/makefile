CC = gcc
CFLAGS = -I./include/ -c -O0 #-Wall -Wextra
LFLAGS = -fno-lto
OBJ = ./build/pxlate.o 
OUT = ./bin/pxlate

$(OUT): $(OBJ)
	$(CC) $(LFLAGS) $(OBJ) -o $(OUT)

./build/pxlate.o: ./src/pxlate.c
	mkdir -p build
	gcc $(CFLAGS) ./src/pxlate.c -o ./build/pxlate.o

#./build/repl.o: ./src/repl.c
#	gcc $(CFLAGS) ./src/repl.c -o ./build/repl.o

#$(OBJ): $(SRC)
#	$(CC) $(CFLAGS) -c $(SRC)

clean:
	rm $(OUT) $(OBJ)
