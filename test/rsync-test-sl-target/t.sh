#!/bin/bash

declare -A arr

arr[0]="sonu"
arr[1]=""
arr[2]="pundir"
arr[3]=" "
arr[4]="\n"

echo ${arr[@]}

echo {2..7..2}
