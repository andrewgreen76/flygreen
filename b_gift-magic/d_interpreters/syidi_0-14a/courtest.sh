make

if [[ "$?" == "0" ]]; then
    ./bin/syidi
    make clean
else
    echo "Build FAILED."
fi
