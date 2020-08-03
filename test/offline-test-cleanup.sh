#!/bin/sh

(cd ../offline-generator && vagrant destroy -f)
(cd ../ansible/test/offline && vagrant destroy -f)

rm -rf ../offline-generator/outputs/
