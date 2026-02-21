#!/bin/bash

exec_src() {

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

for i in {1..1}; do
    exec_src $1
done
