
qemu-system-x86_64    # Runs QEMU without anything to go on.

qemu-system-x86_64 -hda [urboot.bin]    # Runs QEMU off of the linked raw binary
                                        # May involve some stripping or conversion (flattening or binary dumping) 
