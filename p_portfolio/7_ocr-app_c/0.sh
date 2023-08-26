gcc main.c ocr_core.c io_filter.c -o zun.out -lncurses

if test -e zun.out; then
    echo "Generated binary executable zun.out"
    echo "Running the program ..."
    ./zun.out
    echo "End of execution"
    rm zun.out
    echo "Binary executable zun.out removed"
else
    echo "Failed to generate binary executable zun.out"
fi
