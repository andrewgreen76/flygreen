#!/bin/bash

# Specify the source file or directory
source_file="~/flygreen/u_web/."

# Specify the target location and name of the symlink
symlink_name="to-u"

# Create the symbolic link
ln -s "$source_file" "$symlink_name"
