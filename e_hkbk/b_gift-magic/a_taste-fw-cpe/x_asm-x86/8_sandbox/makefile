# Makefile for the assembly program

# Compiler and assembler
ASSEMBLER = nasm
LINKER = ld

# Source and target file names
SRC = hello.asm
OBJ = hello.o
EXE = i_hello

# Default target
all: $(EXE)

# Compile the assembly code
$(OBJ): $(SRC)
	$(ASSEMBLER) -f elf $(SRC) -o $(OBJ)

# Link the object file to create an executable
$(EXE): $(OBJ)
	$(LINKER) -m elf_i386 $(OBJ) -o $(EXE)   # Either "gcc -m32" or "ld -m elf_i386"

# Clean up object and executable files
clean:
	rm -f $(OBJ) $(EXE)

# Run the program
run: $(EXE)
	./$(EXE)
# make clean
