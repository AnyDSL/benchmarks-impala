#!/bin/bash

clang -O2 lib.c -c

for F in fannkuch fasta mandelbrot meteor nbody spectral
do
    echo ">>> building ${F}_c.out"
    clang -O2 -std=c99 ${F}.c -o ${F}_c.out -lm

    echo ">>> building ${F}_impala.out"
    impala ${F}.impala -emit-llvm
    clang -O2 lib.o ${F}.bc -lm -o ${F}_impala.out
done
