#!/bin/bash

mkdir build
cmake -S . -B build
while make -C build -j4; do
    touch shared-resourceA.xyz
done
