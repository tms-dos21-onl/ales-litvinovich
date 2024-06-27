#!/bin/sh

if [ $# -eq 0 ]; then
  echo "���������� �������� ����� � �������� ���������"
  exit 1
fi

number=$1
if ! echo "$number" | grep -Eq '^-?[0-9]+$'; then
  echo "�������� �� �������� ������"
  exit 1
fi

if [ $(($number % 2)) -eq 0 ]; then
  echo "׸����"
else
  echo "��������"
fi