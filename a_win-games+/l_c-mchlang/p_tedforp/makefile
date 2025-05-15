CC = gcc
CFLAGS = -I./include/ -c -O0 #-Wall -Wextra
LFLAGS = -fno-lto
OBJ = ./build/syidi.o ./build/repl.o ./build/screxec.o ./build/cmdproc.o 
OUT = ./bin/syidi

$(OUT): $(OBJ)
	$(CC) $(LFLAGS) $(OBJ) -o $(OUT)

./build/syidi.o: ./src/syidi.c
	mkdir -p build
	gcc $(CFLAGS) ./src/syidi.c -o ./build/syidi.o

./build/repl.o: ./src/repl.c
	gcc $(CFLAGS) ./src/repl.c -o ./build/repl.o

./build/screxec.o: ./src/screxec.c
	gcc $(CFLAGS) ./src/screxec.c -o ./build/screxec.o

./build/cmdproc.o: ./src/cmdproc.c
	gcc $(CFLAGS) ./src/cmdproc.c -o ./build/cmdproc.o

#$(OBJ): $(SRC)
#	$(CC) $(CFLAGS) -c $(SRC)

clean:
	rm $(OUT) $(OBJ)
