#!/bin/bash
set -e

DIR="$(cd "$(dirname "$0")" ; pwd -P)"

function status {
    echo "[*]" $@
}

# Setup symlinks
for file in $DIR/*; do
    filename=$(basename $file)
    if [[ "$filename" != "$(basename $0)" ]]; then
        if [ -e $HOME/.$filename ]; then
            if ! [ -h $HOME/.$filename ]; then
                # remove existing dotfile
                status "deleted existing file $HOME/.$filename"
                rm $HOME/.$filename
            fi
        fi
        status "installing $filename --> .$filename"
        ln -s $DIR/$filename $HOME/.$filename
    fi
done

