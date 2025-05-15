CC = gcc
CFLAGS = -I./include/ -c -O0 #-Wall -Wextra
LFLAGS = -fno-lto
OBJ = ./build/pxlate.o 
OUT = ./bin/pxlate

# Write the rules top-down from final product (bin.exec) to the independent rules. 

$(OUT): $(OBJ) rsrc_dirs
	$(CC) $(LFLAGS) $(OBJ) -o $(OUT)

./build/pxlate.o: ./src/pxlate.c rsrc_dirs 
	$(CC) $(CFLAGS) ./src/pxlate.c -o ./build/pxlate.o

rsrc_dirs:
	mkdir -p build bin 

clean:
	rm -f $(OUT) $(OBJ)  # -f to kill the 'non-existent files' error. 
