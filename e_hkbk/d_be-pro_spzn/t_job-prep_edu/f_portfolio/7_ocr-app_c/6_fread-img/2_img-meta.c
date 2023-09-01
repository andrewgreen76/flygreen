#include <stdio.h>
#include <stdint.h> // For fixed-width types

#pragma pack(push, 1) // Ensure that structure is packed without padding
typedef struct {
  uint16_t signature; // BM
  uint32_t fileSize; 
  uint32_t reserved;
  uint32_t dataOffset;
  uint32_t headerSize;
  int32_t width;
  int32_t height;
  uint16_t planes;
  uint16_t bitsPerPixel;
  uint32_t compression;
  uint32_t rawBmpSize;
  uint32_t horizRes;
  uint32_t vertRes;
  uint32_t numColors;
  uint32_t numImptColors;
} BMPHeader;
#pragma pack(pop)

int main() {
  FILE *bmpFile = fopen("image.bmp", "rb");
  if (bmpFile == NULL) {
    printf("Failed to open BMP file.\n");
    return 1;
  }

  BMPHeader header;
  fread(&header, sizeof(header), 1, bmpFile);

  int width = header.width;
  int height = header.height;

  printf("Width: %d\nHeight: %d\n", width, height);

  fclose(bmpFile);

  return 0;
}
