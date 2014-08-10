MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native  pidigits.c -o pidigits.gcc_run -lgmp
rm pidigits.c
0.09s to complete and log all make actions

COMMAND LINE:
./pidigits.gcc_run 10000

MAKE:
/usr/local/src/rust-0.11.0-i686-unknown-linux-gnu/bin/rustc --opt-level=3 pidigits.rs -o pidigits.rust_run
rm pidigits.rs
2.44s to complete and log all make actions

COMMAND LINE:
./pidigits.rust_run 10000


MAKE:
mv pidigits.ghc-4.ghc pidigits.ghc-4.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts  pidigits.ghc-4.hs -o pidigits.ghc-4.ghc_run
[1 of 1] Compiling Main             ( pidigits.ghc-4.hs, pidigits.ghc-4.o )
Linking pidigits.ghc-4.ghc_run ...
rm pidigits.ghc-4.hs
1.20s to complete and log all make actions

COMMAND LINE:
./pidigits.ghc-4.ghc_run  10000
