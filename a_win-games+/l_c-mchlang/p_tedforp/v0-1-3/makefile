CC = gcc
CFLAGS = -I./include/ -c -O0 #-Wall -Wextra
LFLAGS = -fno-lto
OBJ = ./build/pixelator.o ./build/ansi.o ./build/timer.o
OUT = ./bin/pixelator

##########################################################
# Write the rules top-down from final product (bin.exec) to the independent targets. 

$(OUT): $(OBJ) rsrc_dirs
	$(CC) $(LFLAGS) $(OBJ) -o $(OUT)

./build/pixelator.o: ./src/pixelator.c rsrc_dirs 
	$(CC) $(CFLAGS) ./src/pixelator.c -o ./build/pixelator.o

./build/ansi.o: ./src/ansi.c rsrc_dirs 
	$(CC) $(CFLAGS) ./src/ansi.c -o ./build/ansi.o

./build/timer.o: ./src/timer.c rsrc_dirs 
	$(CC) $(CFLAGS) ./src/timer.c -o ./build/timer.o

rsrc_dirs:
	mkdir -p build bin 

##########################################################
# -f to kill the 'non-existent files' error event. 
clean:
	rm -f $(OUT) $(OBJ)
#rm -f $(OBJ)
#clear
#ls -1
