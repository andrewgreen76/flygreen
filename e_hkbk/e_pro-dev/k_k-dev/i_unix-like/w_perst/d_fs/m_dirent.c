struct dirent {
  char d_name[256];        // filename
  ino_t d_inode;             // inode number
  off_t d_offset;             // offset to the next dirent
  unsigned short d_recordlen; // length of this record
  unsigned char d_type;    // type of file
};
