import pygame

# Initialize Pygame
pygame.init()

# Get the screen dimensions
screen_info = pygame.display.Info()
screen_width = screen_info.current_w
screen_height = screen_info.current_h

# Create the screen
screen = pygame.display.set_mode((screen_width, screen_height), pygame.FULLSCREEN)

# Set the pixel color
pixel_color = (255, 0, 0)  # Red color (RGB values)

# Set the pixel position to the center of the screen
pixel_position = (screen_width // 2, screen_height // 2)

# Draw the pixel on the screen
screen.set_at(pixel_position, pixel_color)
pygame.display.update()

# Wait for a keypress or a certain time
pygame.time.wait(3000)  # Wait for 3 seconds

# Quit Pygame
pygame.quit()
