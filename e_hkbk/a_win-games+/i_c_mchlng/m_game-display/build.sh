#gcc -o gtk_drawing_example gtk_drawing_example.c $(pkg-config --cflags --libs gtk+-3.0)
#gcc -o run vroom.c $(pkg-config --cflags --libs gtk+-3.0)
gcc -o run vroom.c $(pkg-config --cflags --libs gtk+-3.0)
