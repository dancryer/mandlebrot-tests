#!/bin/sh

echo "\033[34mPreparing...\033[0m"
gcc mandlebrot.c -o mandlebrot-c -O3 -mavx2 -fomit-frame-pointer -funroll-loops -ftree-vectorize -march=native 2>&1
go build -o mandlebrot-go mandlebrot.go
mv mandlebrot.java Mandlebrot.java
javac Mandlebrot.java

if [ `command -v dotnet` ]; then
    dotnet build cs/Mandlebrot.csproj -c Release -o ./ 2>&1
fi

echo ""

echo "\033[31mC version\033[0m"
time ./mandlebrot-c
echo ""

echo "\033[31mGo version\033[0m"
time ./mandlebrot-go
echo ""

echo "\033[31mNodeJS version\033[0m"
time node mandlebrot.js
echo ""

echo "\033[31mJava version\033[0m"
if [ `command -v java` ]; then
    time java Mandlebrot
else
    echo "\033[31m!!! SKIPPING - dotnet not installed\033[0m"
fi
echo ""

echo "\033[31mC# version\033[0m"

if [ `command -v dotnet` ]; then
    time dotnet ./cs/Mandlebrot.dll
else
    echo "\033[31m!!! SKIPPING - dotnet not installed\033[0m"
fi

echo ""

echo "\033[31mPHP version\033[0m"
time php mandlebrot.php
echo ""

echo "\033[34mCleaning up...\033[0m"
rm -f mandlebrot-c
rm -f mandlebrot-go
rm -f Mandlebrot.class
rm -Rf ./cs/*.json ./cs/obj ./cs/*.pdb ./cs/*.dll
mv Mandlebrot.java mandlebrot.java
echo "Done."
echo ""
