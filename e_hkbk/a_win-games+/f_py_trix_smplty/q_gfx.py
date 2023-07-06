import pygame

# Initialize Pygame
pygame.init()

# Set screen dimensions
screen_width, screen_height = 800, 600

# Create the screen
screen = pygame.display.set_mode((screen_width, screen_height))

# Set the pixel color
pixel_color = (255, 0, 0)  # Red color (RGB values)

# Set the pixel position
pixel_position = (400, 300)  # Coordinates (x, y) of the pixel

# Draw the pixel on the screen
screen.set_at(pixel_position, pixel_color)
pygame.display.update()

# Wait for a keypress or a certain time
pygame.time.wait(3000)  # Wait for 3 seconds

# Quit Pygame
pygame.quit()
