#include <stdio.h>
#include <sys/mman.h>
#include <fcntl.h>
#include <unistd.h>

int main() {
  // Open the file for reading
  int fd = open("1_victim.txt", O_RDONLY); // The file now has a unique integer representing it. That integer is logged into the fd_table. 
  if (fd == -1) {
    perror("Error opening file");
    return 1; // Return error
  }

  // Get the file size
  off_t file_size = lseek(fd, 0, SEEK_END); // 0 offset -> file end offset 
  if (file_size == -1) {
    perror("Error getting file size");
    close(fd);
    return 1; // Return error
  }

  // Map the file into (process space) memory : 
  void *addr = mmap(NULL, file_size, PROT_READ, MAP_PRIVATE, fd, 0); // addr = start_addr of MAPPED MEMORY REGION 
  if (addr == MAP_FAILED) {
    perror("Error mapping file into memory");
    close(fd);
    return 1; // Return error
  }

  // Output the address of a byte (for example, the first byte)
  printf("Absolute address of byte: %p\n", addr);

  // Unmap the memory and close the file
  munmap(addr, file_size);
  close(fd);

  return 0; // Return success
}
