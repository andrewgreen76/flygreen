struct journal {
  
  struct super_blk s; 
     // . final addresses of blocks involved
     // . TID - transaction identifier
  struct trans_desc_blk * tb; 
  struct write_ops_blk * ops;
     // . content before (over)writing to the disk
  struct commit_blk * cb; 
     // . w/ TID 
};
