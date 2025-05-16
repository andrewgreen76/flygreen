make

if [[ "$?" == "0" ]]; then  # Retd statcd : Did 'make' succeed ? 
    ./bin/pixelator
    make clean
else
    echo "Build FAILED."
fi
