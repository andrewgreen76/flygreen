#!/bin/bash

fist= grep -o "http.*" "$1"
firefox "$fist"
