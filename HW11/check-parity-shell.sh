#!/bin/sh

if [ $# -eq 0 ]; then
  echo "Необходимо передать число в качестве аргумента"
  exit 1
fi

number=$1
if ! echo "$number" | grep -Eq '^-?[0-9]+$'; then
  echo "Аргумент не является числом"
  exit 1
fi

if [ $(($number % 2)) -eq 0 ]; then
  echo "Чётное"
else
  echo "Нечётное"
fi