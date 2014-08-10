MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -std=c99 -pthread revcomp.gcc-2.c -o revcomp.gcc-2.gcc_run 
revcomp.gcc-2.c: In function ‘main’:
revcomp.gcc-2.c:92:9: warning: ignoring return value of ‘write’, declared with attribute warn_unused_result [-Wunused-result]
    write(fileno(stdout), buf, end);
         ^
rm revcomp.gcc-2.c
0.12s to complete and log all make actions

COMMAND LINE:
./revcomp.gcc-2.gcc_run 0 < revcomp-input25000000.txt

MAKE:
mv revcomp.ghc-3.ghc revcomp.ghc-3.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts -funfolding-use-threshold=32 -XMagicHash -XUnboxedTuples revcomp.ghc-3.hs -o revcomp.ghc-3.ghc_run
[1 of 1] Compiling Main             ( revcomp.ghc-3.hs, revcomp.ghc-3.o )
Linking revcomp.ghc-3.ghc_run ...
rm revcomp.ghc-3.hs
1.19s to complete and log all make actions

COMMAND LINE:
./revcomp.ghc-3.ghc_run  0 < revcomp-input25000000.txt
