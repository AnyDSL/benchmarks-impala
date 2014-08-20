#!/bin/bash

clang -O2 lib.c -c

for F in fannkuch mandelbrot nbody
do
    echo ">>> building ${F}_c.out"
    clang -O2 ${F}.c -o ${F}_c.out -lm

    echo ">>> building ${F}_impala.out"
    impala ${F}.impala -emit-llvm
    clang -O2 lib.o ${F}.bc -lm -o ${F}_impala.out
done
