CC = gcc
CFLAGS = -I./include/ -c -O0 #-Wall -Wextra
LFLAGS = -fno-lto
MAIN = tedforp
OBJ = ./build/$(MAIN).o ./build/ansi.o ./build/timer.o
OUT = ./bin/$(MAIN)

##########################################################
# Write the rules top-down from final product (bin.exec) to the independent targets. 

$(OUT): $(OBJ) rsrc_dirs
	$(CC) $(LFLAGS) $(OBJ) -o $(OUT)

./build/$(MAIN).o: ./src/$(MAIN).c rsrc_dirs 
	$(CC) $(CFLAGS) ./src/$(MAIN).c -o ./build/$(MAIN).o

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
