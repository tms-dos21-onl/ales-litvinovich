#!/bin/bash
[ $# -eq 0 ] && echo "���������� �������� ����� � �������� ���������" && exit 1 
echo "$1" | grep -Eq '^-?[0-9]+$' || { echo "�������� �� �������� ������"; exit 1; }
echo $(( $1 % 2 )) | grep -q 0 && echo "׸����" || echo "��������"