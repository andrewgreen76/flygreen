sudo virt-install --name win11a --ram 4096 --vcpus 2 --disk path=win11a.img,format=qcow2 --os-variant win11 --cdrom /home/andrew/y_pkgs-isos/Win11_22H2_English_x64v2.iso --graphics spice --network bridge=virbr0