#!/bin/bash

STOW_DIR="$HOME/mydots"
TARGET_DIR="$HOME"

cd "$STOW_DIR" || {
	echo "Failed to enter $STOW_DIR"
	exit 1
}

for dir in */; do
	dir="${dir%/}"

	echo "Unstowing $dir..."
	stow --delete -v -t "$TARGET_DIR" "$dir"

	echo "Copying files from $dir to $TARGET_DIR..."
	(cd "$dir" && cp -a . "$TARGET_DIR")
done

echo "Done! Verify files in $TARGET_DIR."
