#include <fcntl.h>
#include <linux/fb.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>

int main() {
    int fb_fd;
    struct fb_var_screeninfo vinfo;
    unsigned char* fbp;
    int screensize;

    // Open the framebuffer device
    fb_fd = open("/dev/fb0", O_RDWR);
    if (fb_fd == -1) {
        perror("Unable to open framebuffer device");
        return 1;
    }

    // Get variable screen information
    if (ioctl(fb_fd, FBIOGET_VSCREENINFO, &vinfo)) {
        perror("Error reading variable information");
        close(fb_fd);
        return 1;
    }

    // Calculate the size of the framebuffer in bytes
    screensize = vinfo.yres_virtual * vinfo.xres_virtual * vinfo.bits_per_pixel / 8;

    // Map the framebuffer to memory
    fbp = (unsigned char*)mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fb_fd, 0);
    if ((int)fbp == -1) {
        perror("Failed to mmap");
        close(fb_fd);
        return 1;
    }

    // Fill the framebuffer with black
    memset(fbp, 0, screensize);

    // Unmap the framebuffer
    munmap(fbp, screensize);

    // Close the framebuffer device
    close(fb_fd);

    return 0;
}
