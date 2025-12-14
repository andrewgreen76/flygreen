#srcname=
#as 2.s -o 2.o
#ld 2.o -o test
#./test
#
#CC = gcc
#CFLAGS = -Wall

ASMR = as
AFLAGS = 
SRC = 1_ttysh.s
OBJ = tty.o
BIN = tty

all: $(BIN)

$(BIN): $(SRC)
	$(ASMR) $(AFLAGS) $(SRC) -o $(OBJ)
	ld $(OBJ) -o $(BIN)

clean:
	rm -f $(OBJ) $(BIN)
