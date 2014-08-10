MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -fopenmp -mfpmath=sse -msse2 spectralnorm.gcc-3.c -o spectralnorm.gcc-3.gcc_run -lm
rm spectralnorm.gcc-3.c
0.15s to complete and log all make actions

COMMAND LINE:
./spectralnorm.gcc-3.gcc_run 5500


MAKE:
mv spectralnorm.ghc-4.ghc spectralnorm.ghc-4.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts -XMagicHash -fexcess-precision spectralnorm.ghc-4.hs -o spectralnorm.ghc-4.ghc_run
[1 of 1] Compiling Main             ( spectralnorm.ghc-4.hs, spectralnorm.ghc-4.o )
Linking spectralnorm.ghc-4.ghc_run ...
rm spectralnorm.ghc-4.hs
1.32s to complete and log all make actions

COMMAND LINE:
./spectralnorm.ghc-4.ghc_run  5500
