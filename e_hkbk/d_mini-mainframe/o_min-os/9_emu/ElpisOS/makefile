all:
	nasm -f bin ./boot.asm -o ./boot.bin 		# boot sector {0x0 -> 0x200} as raw binary 
	dd if=./n_msg.txt >> ./boot.bin			# append the n_msg file text 
	 # dd if=/dev/zero bs=512 count=1 >> ./boot.bin	# append nulls to ./boot/bin up to the file's byte count of 512 
