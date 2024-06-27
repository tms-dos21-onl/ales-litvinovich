#!/bin/bash
while read -r file; do
  if [ -s "$file" ]; then
    echo "$file"
  fi
done