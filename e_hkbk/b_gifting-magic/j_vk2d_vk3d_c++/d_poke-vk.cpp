VkImageCreateInfo imageCreateInfo = {};
imageCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_CREATE_INFO;
imageCreateInfo.imageType = VK_IMAGE_TYPE_2D;
imageCreateInfo.format = VK_FORMAT_R8G8B8A8_UNORM;
imageCreateInfo.extent.width = 1;
imageCreateInfo.extent.height = 1;
imageCreateInfo.extent.depth = 1;
imageCreateInfo.mipLevels = 1;
imageCreateInfo.arrayLayers = 1;
imageCreateInfo.samples = VK_SAMPLE_COUNT_1_BIT;
imageCreateInfo.tiling = VK_IMAGE_TILING_LINEAR;
imageCreateInfo.usage = VK_IMAGE_USAGE_TRANSFER_SRC_BIT;

VkImage image;
vkCreateImage(device, &imageCreateInfo, nullptr, &image);

VkMemoryRequirements memoryRequirements = {};
vkGetImageMemoryRequirements(device, image, &memoryRequirements);

VkMemoryAllocateInfo memoryAllocateInfo = {};
memoryAllocateInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
memoryAllocateInfo.allocationSize = memoryRequirements.size;
memoryAllocateInfo.memoryTypeIndex = findMemoryTypeIndex(memoryRequirements.memoryTypeBits, VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT);

VkDeviceMemory imageMemory;
vkAllocateMemory(device, &memoryAllocateInfo, nullptr, &imageMemory);

vkBindImageMemory(device, image, imageMemory, 0);

VkImageViewCreateInfo imageViewCreateInfo = {};
imageViewCreateInfo.sType = VK_STRUCTURE_TYPE_IMAGE_VIEW_CREATE_INFO;
imageViewCreateInfo.image = image;
imageViewCreateInfo.viewType = VK_IMAGE_VIEW_TYPE_2D;
imageViewCreateInfo.format = VK_FORMAT_R8G8B8A8_UNORM;
imageViewCreateInfo.subresourceRange.aspectMask = VK_IMAGE_ASPECT_COLOR_BIT;
imageViewCreateInfo.subresourceRange.baseMipLevel = 0;
imageViewCreateInfo.subresourceRange.levelCount = 1;
imageViewCreateInfo.subresourceRange.baseArrayLayer = 0;
imageViewCreateInfo.subresourceRange.layerCount = 1;

VkImageView imageView;
vkCreateImageView(device, &imageViewCreateInfo, nullptr, &imageView);

VkBufferCreateInfo bufferCreateInfo = {};
bufferCreateInfo.sType = VK_STRUCTURE_TYPE_BUFFER_CREATE_INFO;
bufferCreateInfo.size = 4;
bufferCreateInfo.usage = VK_BUFFER_USAGE_TRANSFER_SRC_BIT;

VkBuffer buffer;
vkCreateBuffer(device, &bufferCreateInfo, nullptr, &buffer);

VkMemoryRequirements bufferMemoryRequirements = {};
vkGetBufferMemoryRequirements(device, buffer, &bufferMemoryRequirements);

VkMemoryAllocateInfo bufferMemoryAllocateInfo = {};
bufferMemoryAllocateInfo.sType = VK_STRUCTURE_TYPE_MEMORY_ALLOCATE_INFO;
bufferMemoryAllocateInfo.allocationSize = bufferMemoryRequirements.size;
bufferMemoryAllocateInfo.memoryTypeIndex = findMemoryTypeIndex(bufferMemoryRequirements.memoryTypeBits, VK_MEMORY_PROPERTY_HOST_VISIBLE_BIT);

VkDeviceMemory bufferMemory;
vkAllocateMemory(device, &bufferMemoryAllocateInfo, nullptr, &bufferMemory);

vkBindBufferMemory(device, buffer, bufferMemory, 0);

void* bufferData;
vkMapMemory(device, bufferMemory, 0, bufferCreateInfo.size, 0, &bufferData);
memcpy(bufferData, &(uint32_t)0xFFFFFFFF, sizeof(uint
