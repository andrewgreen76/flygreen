
// gcc -o wayland_black_screen wayland_black_screen.c -lwayland-client

#include <wayland-client.h>
#include <wayland-egl.h>
#include <wayland-cursor.h>
#include <wayland-util.h>
#include <wayland-client-protocol.h>

static void registry_handle_global(void *data, struct wl_registry *registry, uint32_t id,
                                   const char *interface, uint32_t version) {}

static void registry_handle_global_remove(void *data, struct wl_registry *registry, uint32_t id) {}

int main() {
    struct wl_display *display = wl_display_connect(NULL);
    if (!display) {
        fprintf(stderr, "Unable to connect to Wayland display\n");
        return 1;
    }

    struct wl_registry *registry = wl_display_get_registry(display);
    const struct wl_registry_listener registry_listener = {
        .global = registry_handle_global,
        .global_remove = registry_handle_global_remove,
    };

    wl_registry_add_listener(registry, &registry_listener, NULL);
    wl_display_dispatch(display);
    wl_display_roundtrip(display);

    // Create a simple black window covering the screen
    struct wl_compositor *compositor = wl_registry_bind(registry, 1, &wl_compositor_interface, 4);
    struct wl_surface *surface = wl_compositor_create_surface(compositor);
    struct wl_shell *shell = wl_registry_bind(registry, 2, &wl_shell_interface, 1);
    struct wl_shell_surface *shell_surface = wl_shell_get_shell_surface(shell, surface);

    // Set the surface type to "fullscreen"
    wl_shell_surface_set_toplevel(shell_surface);
    
    // Set the background color to black
    uint32_t color = 0xFF000000; // Black in ARGB format
    wl_surface_set_color(surface, color);

    // Commit the changes and display the black window
    wl_surface_commit(surface);
    wl_display_roundtrip(display);

    // Keep the program running
    while (wl_display_dispatch(display) != -1) {
        // This loop will keep the window open until you manually close it
    }

    // Cleanup and disconnect from Wayland display
    wl_shell_surface_destroy(shell_surface);
    wl_surface_destroy(surface);
    wl_shell_destroy(shell);
    wl_compositor_destroy(compositor);
    wl_registry_destroy(registry);
    wl_display_disconnect(display);

    return 0;
}
