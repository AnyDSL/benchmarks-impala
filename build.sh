#!/bin/bash

clang -O2 lib.c -c

for F in aobench fannkuch fasta mandelbrot meteor nbody pidigits spectral regex
do
    echo ">>> building ${F}_c.out"
    clang -O2 -std=gnu99 ${F}.c -o ${F}_c.out -lm -lpcre -lgmp -s

    echo ">>> building ${F}_impala.out"
    impala ${F}.impala -emit-llvm
    clang -O2 lib.o ${F}.bc -lm -lpcre -lgmp -s -o ${F}_impala.out
done
