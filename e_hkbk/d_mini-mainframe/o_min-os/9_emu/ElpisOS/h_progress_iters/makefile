all:
	nasm -f bin ./boot.asm -o ./boot.bin 		# assemble/link boot sector code {0x0 -> 0x200} as raw binary (no headers) 
	dd if=./n_msg.txt >> ./boot.bin			# append the n_msg file text 
	dd if=/dev/zero bs=512 count=1 >> ./boot.bin	# append 512 nulls to ./boot/bin :
                                                          # pads the second sector ,
                                                          # => makes the binary disk image functional
                                                          # spills into sector 2 , but that one is just full of nulls 
# CONCLUSION : 
#
# 1st sector - boot code
# 2nd sector - some text + padding (sectors must be complete) 
# 3rd sector - ignored and abandoned.
  # It is either at a sector's first byte being null or the sector's last byte being null where fdisk stops loading the image.
