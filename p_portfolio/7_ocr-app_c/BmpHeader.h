#ifndef BMPHEADER_H
#define BMPHEADER_H
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
} BmpHeader;
#pragma pack(pop)

#endif
