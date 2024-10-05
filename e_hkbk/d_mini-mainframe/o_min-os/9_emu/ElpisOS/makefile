all:
	nasm -f bin ./boot.asm -o ./boot.bin 		# boot code as raw binary 
	dd if=./n_msg.txt >> ./boot.bin			# 
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin
