/* BLUEPRINT FOR FS JOURNAL : 

struct jour_build {
  
  struct super_blk s; 
     // . final addresses of blocks involved
     // . TID - transaction identifier
  struct trans_desc_blk * tb; 
  struct write_ops_blk * ops;
     // . content before (over)writing to the disk
  struct commit_blk * cb; 
     // . w/ TID 
};
*/


struct jour_entry {
    uint32_t transactionID;      // Unique identifier for the transaction
    uint8_t operationType;       // Type of operation (e.g., 1 for CREATE, 2 for UPDATE, 3 for DELETE)
    uint64_t affectedInode;      // Inode number of the affected file or directory
    char filePath[MAX_PATH];     // Path to the affected file or directory
    uint64_t beforeValue;        // Value before the change (for updates)
    uint64_t afterValue;         // Value after the change (for updates)
    uint64_t timestamp;          // Timestamp indicating when the entry was created
    uint32_t checksum;           // Checksum for data integrity
    bool commitFlag;             // Flag indicating whether the transaction is committed
};
