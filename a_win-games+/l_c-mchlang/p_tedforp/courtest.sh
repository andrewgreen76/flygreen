make

if [[ "$?" == "0" ]]; then  # Retd statcd : Did 'make' succeed ? 
    ./bin/pxlate
    make clean
else
    echo "Build FAILED."
fi
