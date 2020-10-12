#!/bin/sh

. ./scripts/load-config.sh

OUTDIR=outputs/offline-files
if [ ! -e outputs/offline-files ]; then
    mkdir -p $OUTDIR
fi

parse_yaml() {
    for file in $*; do
        echo "Processing $file"
        echo "# $file" >> outputs/yaml-images.txt
        grep "^ *image: " $file | sed 's/^ *image: *//' | sort | uniq >> outputs/yaml-images.txt
    done
}

# Generate image lists from yaml
echo "==> Updating outputs/yaml-images.txt"
/bin/rm outputs/yaml-images.txt >/dev/null 2>&1

for i in $(cat yamls/ansible-yamls.txt | grep -v "^#" | sed 's/^/..\/ansible\/roles\//'); do
    if [ -f $i ]; then
        parse_yaml $i
    fi
done

#parse_yaml yamls/*.y*ml

# Copy yaml files
#cp yamls/*.y*ml $OUTDIR

