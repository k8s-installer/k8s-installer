#!/bin/sh

. ./config.sh

OUTDIR=outputs/offline-files
if [ ! -e outputs/offline-files ]; then
    mkdir -p $OUTDIR
fi

parse_yaml() {
    for file in $*; do
        grep "^ *image: " $file | sed 's/^ *image: *//' | sort | uniq >> outputs/yaml-images.txt
    done
}

# Generate image lists from y aml
echo "==> Updating outputs/yaml-images.txt"
/bin/rm outputs/yaml-images.txt >/dev/null 2>&1
parse_yaml yamls/*.yaml

# Copy yaml files
cp yamls/*.yaml $OUTDIR
