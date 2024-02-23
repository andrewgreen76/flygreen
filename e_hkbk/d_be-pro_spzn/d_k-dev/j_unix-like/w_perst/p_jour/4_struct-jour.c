struct journal {
  
  struct init_blk ib; 
     // . final addresses of blocks involved
     // . TID - transaction identifier
  struct write_ops_blks * ops;
     // . content before (over)writing to the disk
  struct commit_blk cb; 
     // . w/ TID 
};
