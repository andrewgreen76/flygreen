#include <gtk/gtk.h>

// Function to handle closing of the window
static void destroy(GtkWidget *widget, gpointer data) {
    gtk_main_quit();  // Quit the GTK main loop
}

int main(int argc, char *argv[]) {
    GtkWidget *window;

    gtk_init(&argc, &argv);  // Initialize GTK

    // Create a new window
    window = gtk_window_new(GTK_WINDOW_TOPLEVEL);
    gtk_window_set_title(GTK_WINDOW(window), "Hello, GTK!");
    gtk_window_set_default_size(GTK_WINDOW(window), 300, 200);
    g_signal_connect(window, "destroy", G_CALLBACK(destroy), NULL);

    // Display all widgets
    gtk_widget_show_all(window);

    // Start the GTK main loop
    gtk_main();

    return 0;
}
