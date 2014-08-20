#!/bin/bash

clang -O2 lib.c -c

for F in fannkuch nbody
do
    echo ">>> building ${F}_c"
    clang -O2 ${F}.c -o ${F}_c -lm

    echo ">>> building ${F}_impala"
    impala ${F}.impala -emit-llvm
    clang -O2 lib.o ${F}.bc -lm -o ${F}_impala
done
