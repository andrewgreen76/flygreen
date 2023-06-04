SLASH="/"
ABSPATH=""

# git store
gs () {
    ABSPATH=$(pwd)$SLASH$1
    echo "Stored: $ABSPATH"
}

#git drop+dup
gd () {
    echo "Cloned and dropped: $ABSPATH"
}

#git move
gm () {
    echo "Removed and dropped: $ABSPATH"
}
