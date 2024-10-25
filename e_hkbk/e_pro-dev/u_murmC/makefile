OBJECTS=
INCLUDES= -I./    # allows for relative paths instead of having us write out absolute paths 

all: ${OBJECTS}
	gcc main.c ${INCLUDES} ${OBJECTS} -g -o ./main

clean:
	rm ./main
	rm -rf ${OBJECTS}
