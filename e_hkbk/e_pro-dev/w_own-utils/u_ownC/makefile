
OBJECTS= ./build/compiler.o ./build/cmpl_process.o
INCLUDES= -I./    # allows for relative paths instead of having us write out absolute paths 

all: ${OBJECTS}
	gcc main.c ${INCLUDES} ${OBJECTS} -g -o ./main

./build/compiler.o: ./compiler.c
	gcc compiler.c ${INCLUDES} -o ./build/compiler.o -g -c

./build/cmpl_process.o: ./cmpl_process.c
	gcc cmpl_process.c ${INCLUDES} -o ./build/cmpl_process.o -g -c

clean:
	rm ./main
	rm -rf ${OBJECTS}
