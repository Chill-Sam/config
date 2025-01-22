#!/bin/bash



# Check if the file containing package names is provided

if [ -z "$1" ]; then

  echo "Usage: $0 <package_list_file>"

  exit 1

fi



PACKAGE_LIST_FILE="$1"



# Check if the package list file exists

if [ ! -f "$PACKAGE_LIST_FILE" ]; then

  echo "Error: File '$PACKAGE_LIST_FILE' not found!"

  exit 1

fi



# Install all packages in a single pacman command

echo "Installing packages..."

sudo pacman -S --needed --noconfirm $(cat "$PACKAGE_LIST_FILE")



echo "All packages installed successfully."
