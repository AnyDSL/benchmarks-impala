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

for F in aobench fannkuch fasta mandelbrot meteor nbody pidigits spectral regex reverse
do
    echo ">>> building ${F}_c.out"
    clang -O3 -std=gnu99 ${INC_FLAGS} ${F}.c -o ${F}_c.out ${LD_FLAGS} -lm -lpcre -lgmp -s

    echo ">>> building ${F}_impala.out"
    impala ${F}.impala -emit-llvm -O3
    clang -O3 -flto lib.o ${F}.ll ${LD_FLAGS} -lm -lpcre -lgmp -s -o ${F}_impala.out

    #echo ">>> building ${F}_rs.out"
    #rustc --opt-level 3 ${F}.rs -o ${F}_rs.out

    echo ">>> building ${F}_hs.out"
    if [ "${F}" == "fasta" ]
    then
        ghc --make -fllvm -O3 -XBangPatterns -rtsopts -XOverloadedStrings ${F}.hs -o ${F}_hs.out
    else
        ghc --make -fllvm -O3 -XBangPatterns -rtsopts -funfolding-use-threshold=32 -XMagicHash -XUnboxedTuples ${F}.hs -o ${F}_hs.out
    fi
done
