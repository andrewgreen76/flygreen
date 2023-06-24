SLASH="/"
#ABS_PATH_AND_TRG=""
ANCHOR1="/home/andrew/flygreen/e_hkbk/a_win-games+"
ANCHOR2="/home/andrew/flygreen/e_hkbk/b_gift-magic"
ANCHOR3="/home/andrew/flygreen/e_hkbk/d_be-pro_spzn"
    

# Bash configs have a problem of not automatically honoring manual abandonment tokens. 
# Invalidator for abandoned tokens: 
n () {
    echo "lanch: command not found"
}



x () {
    #echo "Command in development"
    # Refer to the same file in one location
    #   instead of having multiple copies of the same runner. 
    # Format : run <lang> <single-tgt>
    #<sh-4-lang>
    if [[ $1 =~ \.([^./]+)$ ]]; then
	ext="${BASH_REMATCH[1]}"
	#echo "File extension: $extension"
	if [[ $ext == "c" ]]; then
	    gcc $1 -o zun.out
	    ./zun.out
	    rm zun.out
	elif [[ $ext == "py" ]]; then
	    python3 $1
	else
	    echo "Per x (): Unknown extension"
	fi
    fi
}



# git store
gs () {
    ABS_PATH_AND_TRG=$(pwd)$SLASH$1
    echo "Stored: $ABS_PATH_AND_TRG"
}

# git drop+dup
gu () {
    cp -r $ABS_PATH_AND_TRG ./
    echo "Cloned and dropped: $ABS_PATH_AND_TRG"
}

# git throw/toss/transfer target 
gt () {
    git mv $ABS_PATH_AND_TRG ./
    echo "Removed and dropped: $ABS_PATH_AND_TRG"
}



# Dir-anchoring funcs:
a1 () {
    ANCHOR1=$(pwd)
    echo "Anchored to 1"
}

a2 () {
    ANCHOR2=$(pwd)
    echo "Anchored to 2"
}

a3 () {
    ANCHOR3=$(pwd)
    echo "Anchored to 3"
}

# Dir-jumping/Door funcs:
d1 () {
    cd $ANCHOR1
}

d2 () {
    cd $ANCHOR2
}

d3 () {
    cd $ANCHOR3
}

