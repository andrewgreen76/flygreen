
DEPS = ./build/kernel.asm.o	# dependencies / object files 


#####################################################################
# $ make [label]
#
# label: [given]    
#	[perform] [w/ given]    # maybe generate and output file
#
# All givens are dependencies that must be resolved if they aren't now. 
#
# There's a structure to `make` entries , but for the most part it's all
#   symbolic resolution. 
#####################################################################


# make [labels] below : 

all: ./bin/boot.bin ./bin/kernel.bin 
	rm -rf ./bin/os.bin
	dd if=./bin/boot.bin >> ./bin/os.bin    # generating our OS build 
	dd if=./bin/kernel.bin >> ./bin/os.bin  # -//- 
	dd if=/dev/zero bs=512 count=100 >> ./bin/os.bin    # defining size of kernel (50 KB) - just to generate a really large number 

./bin/kernel.bin: $(DEPS)
	i686-elf-ld -g -relocatable $(DEPS) -o ./build/kernelfull.o    # We link all object files to one big object file.
	i686-elf-gcc -T ./src/linker.ld -o ./bin/kernel.bin -ffreestanding -O0 -nostdlib ./build/kernelfull.o
        # GCC is a crutch; linker script. See 'man gcc'. No std lib. No optim. No Linux stdlib. 

./bin/boot.bin: ./src/boot/boot.asm
	nasm -f bin ./src/boot/boot.asm -o ./bin/boot.bin 

./build/kernel.asm.o: ./src/kernel.asm
	nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o 

clean:
	rm -rf ./bin/boot.bin
