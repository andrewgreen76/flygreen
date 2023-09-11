#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/mman.h>
#include <unistd.h>

int main() {
    int fbfd = 0;
    struct fb_var_screeninfo vinfo;
    long screensize = 0;
    char *fbp = 0;

    // Open the framebuffer device
    fbfd = open("/dev/fb0", O_RDWR);
    if (fbfd == -1) {
        perror("Error opening framebuffer device");
        return 1;
    }

    // Get variable screen information
    if (ioctl(fbfd, FBIOGET_VSCREENINFO, &vinfo)) {
        perror("Error reading variable information");
        close(fbfd);
        return 1;
    }

    // Calculate the size of the framebuffer in bytes
    screensize = vinfo.yres_virtual * vinfo.xres_virtual * vinfo.bits_per_pixel / 8;

    // Map the framebuffer to memory
    fbp = (char *)mmap(0, screensize, PROT_READ | PROT_WRITE, MAP_SHARED, fbfd, 0);
    if ((intptr_t)fbp == -1) {
        perror("Error mapping framebuffer to memory");
        close(fbfd);
        return 1;
    }

    // Fill the framebuffer with black (all zeros)
    memset(fbp, 0, screensize);

    // Unmap the framebuffer and close the device
    munmap(fbp, screensize);
    close(fbfd);

    return 0;
}
