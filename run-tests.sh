#!/bin/bash

echo -e "\033[34mPreparing...\033[0m"
gcc mandlebrot.c -o mandlebrot-c -O3 -mavx2 -fomit-frame-pointer -funroll-loops -ftree-vectorize -march=native 2>&1
go build -o mandlebrot-go mandlebrot.go
echo ""

echo -e "\033[31mC version\033[0m"
time ./mandlebrot-c
echo ""

echo -e "\033[31mGo version\033[0m"
time ./mandlebrot-go
echo ""

echo -e "\033[31mNode version\033[0m"
time node mandlebrot.js
echo ""

echo -e "\033[31mPHP version\033[0m"
time php mandlebrot.php
echo ""
