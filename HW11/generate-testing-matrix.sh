#!/bin/bash

os=("linux" "windows" "macos")
arch=("x86" "amd64" "arm")

for o in "${os[@]}"; do
  for a in "${arch[@]}"; do
    echo "$o-$a"
  done
done