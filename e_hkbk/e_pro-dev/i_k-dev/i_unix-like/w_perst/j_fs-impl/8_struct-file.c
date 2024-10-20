
// The kernel uses this struct for holding metadata about the CURRENTLY OPEN file : 


struct file {
        int ref;
        char readable;
        char writable;
        struct inode *ip;
        int8_t off;
      };


/*
  References to all open files are stored in the open file table.


  "`struct inode` holds metadata about a file, including information such as file type, permissions, ownership, timestamps, and pointers to data blocks, serv  ing as a central data structure in Unix-like file systems to manage and describe files." 
*/
