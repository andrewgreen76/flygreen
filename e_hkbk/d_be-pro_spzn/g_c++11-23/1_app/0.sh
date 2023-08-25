g++ $1 -o zun.out

if test -e zun.out; then
    echo "Generated binary executable zun.out"
    echo "Running the program ..."
    echo
    ./zun.out
    echo 
    echo "End of execution"
    rm zun.out
    echo "Binary executable zun.out removed"
else
    echo "Failed to generate binary executable zun.out"
fi
