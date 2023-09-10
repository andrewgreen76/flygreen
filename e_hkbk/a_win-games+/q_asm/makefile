# Makefile for the assembly program

# Compiler and assembler
ASSEMBLER = nasm
LINKER = gcc

# Source and target file names
SRC = r_add.asm
OBJ = r_add.o
EXE = r_add

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
