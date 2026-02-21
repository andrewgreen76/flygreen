
DEPS = ./build/kernel.asm.o ./build/kernel.o
INCLUDES = -I./src
FLAGS = -g -ffreestanding -falign-jumps -falign-functions -falign-labels -falign-loops -fstrength-reduce -fomit-frame-pointer -finline-functions -Wno-unused-function -fno-builtin -Werror -Wno-unused-label -Wno-cpp -Wno-unused-parameter -nostdlib -nostartfiles -nodefaultlibs -Wall -O0 -Iinc

all: ./bin/boot.bin ./bin/kernel.bin 
	rm -rf ./bin/os.bin    # because we dd to this file , but what if we don't clean?
                               # All the other object files do get overwritten. 
	dd if=./bin/boot.bin >> ./bin/os.bin    # generating our OS build 
	dd if=./bin/kernel.bin >> ./bin/os.bin  # -//- 
	dd if=/dev/zero bs=512 count=100 >> ./bin/os.bin    # defining size of kernel (50 KB) - just to generate a really large number 

./bin/kernel.bin: $(DEPS)
	i686-elf-ld -g -relocatable $(DEPS) -o ./build/kernelfull.o    # We link all object files to one big object file.
	i686-elf-gcc $(FLAGS) -T ./src/linker.ld -o ./bin/kernel.bin -ffreestanding -O0 -nostdlib ./build/kernelfull.o
        # GCC is a crutch \ Linker script \ See 'man gcc' \ No std lib \ No optim \ No Linux stdlib. 

./bin/boot.bin: ./src/boot/boot.asm
	nasm -f bin ./src/boot/boot.asm -o ./bin/boot.bin 

./build/kernel.asm.o: ./src/kernel.asm
	nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o 

./build/kernel.o: ./src/kernel.c
	i686-elf-gcc $(INCLUDES) $(FLAGS) -std=gnu99 -c ./src/kernel.c -o ./build/kernel.o

clean:
	rm -rf ./bin/boot.bin
	rm -rf ./bin/kernel.bin
	rm -rf ./bin/os.bin
	rm -rf ${DEPS}
	rm -rf ./build/kernelfull.o
