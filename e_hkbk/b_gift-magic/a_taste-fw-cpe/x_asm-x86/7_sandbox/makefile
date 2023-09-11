# Makefile for the assembly program

# Compiler and assembler
ASSEMBLER = nasm
LINKER = ld

# Source and target file names
SRC = hello-n.asm
OBJ = hello-n.o
EXE = i_hello-n

# Default target
all: $(EXE)

# Compile the assembly code
$(OBJ): $(SRC)
	$(ASSEMBLER) -f elf $(SRC) -o $(OBJ)

# Link the object file to create an executable
$(EXE): $(OBJ)
	$(LINKER) -m32 $(OBJ) -o $(EXE)

# Clean up object and executable files
clean:
	rm -f $(OBJ) $(EXE)

# Run the program
run: $(EXE)
	./$(EXE)
# make clean
