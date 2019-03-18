#!/bin/bash

echo -e "\033[34mPreparing...\033[0m"
gcc mandlebrot.c -o mandlebrot-c -O3 -mavx2 -fomit-frame-pointer -funroll-loops -ftree-vectorize -march=native 2>&1
go build -o mandlebrot-go mandlebrot.go
mv mandlebrot.java Mandlebrot.java
javac Mandlebrot.java
echo ""

echo -e "\033[31mC version\033[0m"
time ./mandlebrot-c
echo ""

echo -e "\033[31mGo version\033[0m"
time ./mandlebrot-go
echo ""

echo -e "\033[31mNodeJS version\033[0m"
time node mandlebrot.js
echo ""

echo -e "\033[31mJava version\033[0m"
time java Mandlebrot
echo ""

echo -e "\033[31mPHP version\033[0m"
time php mandlebrot.php
echo ""

echo -e "\033[34mCleaning up...\033[0m"
rm -f mandlebrot-c
rm -f mandlebrot-go
rm -f Mandlebrot.class
mv Mandlebrot.java mandlebrot.java
echo "Done."
echo ""
