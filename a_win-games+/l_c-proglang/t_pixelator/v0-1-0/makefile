CC = gcc
CFLAGS = -I./include/ -c -O0 #-Wall -Wextra
LFLAGS = -fno-lto
OBJ = ./build/pixelator.o 
OUT = ./bin/pixelator

##########################################################
# Write the rules top-down from final product (bin.exec) to the independent targets. 

$(OUT): $(OBJ) rsrc_dirs
	$(CC) $(LFLAGS) $(OBJ) -o $(OUT)

./build/pixelator.o: ./src/pixelator.c rsrc_dirs 
	$(CC) $(CFLAGS) ./src/pixelator.c -o ./build/pixelator.o

rsrc_dirs:
	mkdir -p build bin 

##########################################################
# -f to kill the 'non-existent files' error event. 
clean:
	rm -f $(OBJ)
#rm -f $(OUT) $(OBJ)
#clear
#ls -1
