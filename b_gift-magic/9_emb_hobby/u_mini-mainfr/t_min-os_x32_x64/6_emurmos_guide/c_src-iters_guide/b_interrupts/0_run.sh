make clean
./build.sh
cd bin
qemu-system-x86_64 -hda ./os.bin
