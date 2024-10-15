FILES = ./build/kernel.asm.o	# dependency 


#####################################################################
# $ make [label]
#
# label: [given]
#	[perform] [w/ given]    # maybe generate and output file
#
# There's structure to `make` entries , but for the most part it's all
#   symbolic resolution. 
#####################################################################


# make [labels] below : 

all: ./bin/boot.bin $(FILES)
	dd if=./bin/boot.bin >> ./bin/os.bin

./bin/boot.bin: ./src/boot/boot.bin
	nasm -f bin ./src/boot/boot.asm -o ./bin/boot.bin 

./build/kernel.asm.o: ./src/kernel.asm
	nasm -f elf -g ./src/kernel.asm -o ./build/kernel.asm.o 

clean:
	rm -rf ./bin/boot.bin
