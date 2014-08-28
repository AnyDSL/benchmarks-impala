#!/bin/bash

clang -O3 lib.c -c

case $OSTYPE in
    darwin*)
        LD_FLAGS="-L /opt/local/lib"
        INC_FLAGS="-I /opt/local/include"
        ;;
    *)
        LD_FLAGS=
        INC_FLAGS=
        ;;
esac

for F in aobench fannkuch fasta mandelbrot meteor nbody pidigits spectral regex
do
    echo ">>> building ${F}_c.out"
    clang -O3 -std=gnu99 ${INC_FLAGS} ${F}.c -o ${F}_c.out ${LD_FLAGS} -lm -lpcre -lgmp

    echo ">>> building ${F}_impala.out"
    impala ${F}.impala -emit-llvm
    clang -O3 lib.o ${F}.bc ${LD_FLAGS} -lm -lpcre -lgmp -o ${F}_impala.out

    #echo ">>> building ${F}_rs.out"
    #rustc --opt-level 3 ${F}.rs -o ${F}_rs.out

    #echo ">>> building ${F}_hs.out"
    #ghc --make -fllvm -O3 -XBangPatterns -rtsopts -XOverloadedStrings ${F}.hs -o ${F}_hs.out
done
