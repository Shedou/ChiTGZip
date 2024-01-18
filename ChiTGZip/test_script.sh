#!/bin/bash

echo "1: " $1
echo "2: " $2
echo "3: " $3
echo "4: " $4


cd "$1"
./7zzs.exec "$2" "$3" "$4"
read ff
