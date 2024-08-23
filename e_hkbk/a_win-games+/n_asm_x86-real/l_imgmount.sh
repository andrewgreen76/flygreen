# ~/flygreen/e_hkbk/a_win-games+/n_asm_x86-real/

imgn=disk07

#sudo mkdir /mnt/masm60
sudo mount -o loop "${imgn}.img" /mnt/masm60
cp -r /mnt/masm60/* ~/flygreen/e_hkbk/a_win-games+/n_asm_x86-real/h_masm/$imgn
sudo umount /mnt/masm60
