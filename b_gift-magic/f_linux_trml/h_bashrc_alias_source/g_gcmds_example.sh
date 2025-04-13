SLASH="/"
ABS_PATH_AND_TRG=""
ANCHOR1="/home/andrew/flygreen/e_hkbk/a_win-games+"
ANCHOR2="/home/andrew/flygreen/e_hkbk/b_gift-magic"
ANCHOR3="/home/andrew/flygreen/e_hkbk/f_pro-dev"
ANCHOR4="/home/andrew/flygreen/e_hkbk/e_fill-in-gaps"

# Bash configs have a problem of not automatically de-sourcing removed code/command functions. 
# Invalidator for abandoned tokens: 
n () {
    echo "n: command not found"
}



# Local find:
lf () {
    find . -name "*$1*"
}

gf () {
    find ~/flygreen/ -name "*$1*"
}

# Local grep:
lg () {
    grep -r --binary-files=without-match "$1" *
}

# Global grep:
gg () {
    grep -r --binary-files=without-match "$1" ~/flygreen/*
}

# Create a URL file with the given name , write the given URL link into the file : 
tu () {
    echo "[InternetShortcut]\nURL=$1" > $2
}

# Open the link in the given URL file : 
ou () {
    firefox $(grep -o "http.*" "$1") 2>/dev/null >/dev/null &
    #c
    #c
}

# This command extracts the URL link from a URL file : 
ru () {
    grep -o "http.*" "$1" | xclip -selection clipboard
    echo "URL link cached in memory buffer"
}



# This command simply extracts the file extension and, based on the extension, executes the program/script : 
x () {
    #echo "Command in development"
    # Refer to the same file in one location
    #   instead of having multiple copies of the same runner. 
    # Format : run <lang> <single-tgt>
    #<sh-4-lang>
    if [[ $1 =~ \.([^./]+)$ ]]; then
	ext="${BASH_REMATCH[1]}"
	if [[ $ext == "c" ]]; then
	    gcc $1 -o zun.out
	    ./zun.out
	    rm zun.out
	elif [[ $ext == "cpp" ]]; then
	    g++ $1 -o zun.out
	    ./zun.out
	    rm zun.out
	elif [[ $ext == "py" ]]; then
	    python3 $1
	elif [[ $ext == "sh" ]]; then
	    bash $1
	else
	    echo "Per x (): Unknown extension"
	fi
    fi
}



# git store
gs () {
    ABS_PATH_AND_TRG=$(pwd)$"/"$1
    echo "Cached: $ABS_PATH_AND_TRG"
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
    echo "Cached to 1"
}

a2 () {
    ANCHOR2=$(pwd)
    echo "Cached to 2"
}

a3 () {
    ANCHOR3=$(pwd)
    echo "Cached to 3"
}

a4 () {
    ANCHOR4=$(pwd)
    echo "Cached to 4"
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

d4 () {
    cd $ANCHOR4
}

# Jump to dir of:
jdof () {
    a="$1" # Given str to be used as cmd.
    eval "b=\$( $a )" # Takes the given cmd, encapsulates it in $() for further cmd sub.
    c=`dirname $b`
    cd $c

    # Use as : jdof 'cmd arg'
}

# Make an entry titlebar:
mket () {
    echo "========================================================================================" >> $1
    echo >> $1
    echo "========================================================================================" >> $1
}

sela () {
    head -n $1 | tail -n 1
}

selz () {
    tail -n $1 | head -n 1
}

rei () {

    # Check if the correct number of arguments is provided
    if [ "$#" -ne 2 ]; then
	echo "Rejected. Follow: rei <old_index> <new_index>"
	#exit 1
    fi

    old_index=$1
    new_index=$2

    # Iterate over files and directories in the current working directory
    for item in *; do
	# Skip items that don't start with the old_char
	if [[ $item == $old_index* ]]; then
            # Create the new name by replacing the first character
            new_name="${new_index}${item:1}"
            
            # Rename the file or directory
            mv "$item" "$new_name"

            clear
	    ls -1
	fi
    done

}
