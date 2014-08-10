MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -std=c99 -mfpmath=sse -msse3 fasta.gcc-5.c -o fasta.gcc-5.gcc_run 
rm fasta.gcc-5.c
0.11s to complete and log all make actions

COMMAND LINE:
./fasta.gcc-5.gcc_run 25000000


MAKE:
mv fasta.ghc-2.ghc fasta.ghc-2.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts -XOverloadedStrings fasta.ghc-2.hs -o fasta.ghc-2.ghc_run
[1 of 1] Compiling Main             ( fasta.ghc-2.hs, fasta.ghc-2.o )
Linking fasta.ghc-2.ghc_run ...
rm fasta.ghc-2.hs
1.28s to complete and log all make actions

COMMAND LINE:
./fasta.ghc-2.ghc_run  25000000
