#include <gtk/gtk.h>

// Function to handle closing of the window
static void destroy(GtkWidget *widget, gpointer data) {
    gtk_main_quit();  // Quit the GTK main loop
}

// Function to draw on the drawing area
static gboolean draw_callback(GtkWidget *widget, cairo_t *cr, gpointer data) {
    // Set drawing color to blue
    cairo_set_source_rgb(cr, 0.0, 0.0, 1.0); // Blue color
    
    // Draw a blue pixel at the center of the drawing area
    cairo_rectangle(cr, 50, 50, 1, 1); // X, Y, width, height
    cairo_fill(cr); // Fill the drawn shape with the current color
    
    return FALSE; // Stop further handling of the draw signal
}

int main(int argc, char *argv[]) {
    GtkWidget *window;
    GtkWidget *drawing_area;

    gtk_init(&argc, &argv);  // Initialize GTK

    // Create a new window
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(window), "Hello, GTK with Drawing!");
    gtk_window_set_default_size(GTK_WINDOW(window), 300, 200);
    g_signal_connect(window, "destroy", G_CALLBACK(destroy), NULL);

    // Create a drawing area widget
    drawing_area = gtk_drawing_area_new();
    gtk_container_add(GTK_CONTAINER(window), drawing_area);
    
    // Connect the draw signal to the draw_callback function
    g_signal_connect(G_OBJECT(drawing_area), "draw", G_CALLBACK(draw_callback), NULL);

    // Display all widgets
    gtk_widget_show_all(window);

    // Start the GTK main loop
    gtk_main();

    return 0;
}
