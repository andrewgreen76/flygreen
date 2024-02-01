#!/bin/bash

gcc -o a.out $1 -g
gdb a.out
#rm a.out
