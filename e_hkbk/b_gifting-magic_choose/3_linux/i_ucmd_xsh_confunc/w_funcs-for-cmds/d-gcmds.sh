SLASH="/"
ABS_PATH_AND_TRG=""

# git store
gs () {
    ABS_PATH_AND_TRG=$(pwd)$SLASH$1
    echo "Stored: $ABS_PATH_AND_TRG"
}

#git drop+dup
gc () {
    cp $ABS_PATH_AND_TRG ./
    echo "Cloned and dropped: $ABS_PATH_AND_TRG"
}

#git move
gm () {
    git mv $ABS_PATH_AND_TRG ./
    echo "Removed and dropped: $ABS_PATH_AND_TRG"
}
