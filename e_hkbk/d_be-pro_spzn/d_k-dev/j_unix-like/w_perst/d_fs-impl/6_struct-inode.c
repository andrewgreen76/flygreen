#include <stdint.h>
#include <time.h>

#define INODE_BLOCK_POINTERS 12

struct inode {
  mode_t mode;                 // File type and permissions
  uid_t uid;                   // Owner's user ID
  gid_t gid;                   // Owner's group ID
  off_t size;                  // File size in bytes
  time_t atime;                // Last access time
  time_t mtime;                // Last modification time
  time_t ctime;                // Inode change time
  // no number of data blocks

  // Pointers to data blocks
  uint32_t block_pointers[INODE_BLOCK_POINTERS];
  uint32_t indirect_block_pointer;
  uint32_t double_indirect_block_pointer;
  // ... (additional pointers for more complex file systems)

  // Data location addressed by a block pointer array , not stored as a filepath.
  //  . direct pointers -or- disk addresses/sectors 
  // Filepaths are stored in dir inodes. 
  
  // Other fields as needed by the specific file system
  // ...
};
