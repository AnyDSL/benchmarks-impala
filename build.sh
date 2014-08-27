#!/bin/bash

clang -O3 lib.c -c

for F in aobench fannkuch fasta mandelbrot meteor nbody pidigits spectral regex
do
    echo ">>> building ${F}_c.out"
    clang -O3 -std=gnu99 ${F}.c -o ${F}_c.out -lm -lpcre -lgmp -s

    echo ">>> building ${F}_impala.out"
    impala ${F}.impala -emit-llvm
    clang -O3 lib.o ${F}.bc -lm -lpcre -lgmp -s -o ${F}_impala.out

    #echo ">>> building ${F}_rs.out"
    #rustc --opt-level 3 ${F}.rs -o ${F}_rs.out

    #echo ">>> building ${F}_hs.out"
    #ghc --make -fllvm -O3 -XBangPatterns -rtsopts -XOverloadedStrings ${F}.hs -o ${F}_hs.out
done
