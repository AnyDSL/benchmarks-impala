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

echo "BUILDING"
echo

for F in aobench fannkuch fasta mandelbrot meteor nbody pidigits spectral regex reverse
do
    echo ">>> building ${F}_c.out"
    clang -O3 -std=gnu99 ${INC_FLAGS} ${F}.c -o ${F}_c.out ${LD_FLAGS} -lm -lpcre -lgmp -s

    echo ">>> building ${F}_impala.out"
    impala ${F}.impala -emit-llvm 
    clang -O3 -flto lib.o ${F}.ll ${LD_FLAGS} -lm -lpcre -lgmp -s -o ${F}_impala.out

    if [ -e ${F}.rs ]
    then
        echo ">>> building ${F}_rs.out"
        rustc --opt-level 3 ${F}.rs -o ${F}_rs.out
    fi

    echo ">>> building ${F}_hs.out"
    if [ "${F}" == "fasta" ]
    then
        ghc --make -fllvm -O3 -XBangPatterns -rtsopts -XOverloadedStrings ${F}.hs -o ${F}_hs.out
    else
        ghc --make -fllvm -O3 -XBangPatterns -rtsopts -funfolding-use-threshold=32 -XMagicHash -XUnboxedTuples ${F}.hs -o ${F}_hs.out
    fi
done

echo
echo "<<< generating input_regex.txt"
./fasta_c.out 2500000 > input_regex.txt

echo "<<< generating input_reverse.txt"
./fasta_c.out 50000000 > input_reverse.txt

function benchmark {
    echo ">>> $1"
    for k in 0 1 2 3 4 5 6 7 8 9 10
    do
        TIME=$( ( eval "time $1" ) |& sed -e '/user/!d' -e 's/user.*m//' -e 's/\.//' -e 's/s//')
        echo "#$k: $TIME" >&2
        echo "$TIME"
    done | sort -n | head -n 6 | tail -n 1
}

echo
echo "BENCHMARKING... all reported times are in kiloseconds"
echo

for I in aobench_*.out; do
    benchmark "./$I > out"
done

for I in fannkuch_*.out; do
    benchmark "./$I 12 > out"
done

for I in fasta_*.out; do
    benchmark "./$I 25000000 > out"
done

for I in mandelbrot_*.out; do
    benchmark "./$I 5000 > out"
done

for I in meteor_*.out; do
    benchmark "./$I 2098 > out"
done

for I in nbody_*.out; do
    benchmark "./$I 50000000 > out"
done

for I in pidigits_*.out; do
    benchmark "./$I 10000 > out"
done

for I in spectral_*.out; do
    benchmark "./$I 5500 > out"
done

for I in regex_*.out; do
    benchmark "./$I < input_regex.txt > out"
done

for I in reverse_*.out; do
    benchmark "./$I < input_reverse.txt > out"
done
