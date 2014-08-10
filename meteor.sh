MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native  meteor.c -o meteor.gcc_run 
rm meteor.c
0.73s to complete and log all make actions

COMMAND LINE:
./meteor.gcc_run 2098

MAKE:
/usr/local/src/rust-0.11.0-i686-unknown-linux-gnu/bin/rustc --opt-level=3 meteor.rs -o meteor.rust_run
rm meteor.rs
3.98s to complete and log all make actions

COMMAND LINE:
./meteor.rust_run 2098

MAKE:
mv meteor.ghc-5.ghc meteor.ghc-5.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts -XScopedTypeVariables -XTypeSynonymInstances -XFlexibleInstances meteor.ghc-5.hs -o meteor.ghc-5.ghc_run
[1 of 1] Compiling Main             ( meteor.ghc-5.hs, meteor.ghc-5.o )
Linking meteor.ghc-5.ghc_run ...
rm meteor.ghc-5.hs
5.52s to complete and log all make actions

COMMAND LINE:
./meteor.ghc-5.ghc_run  2098
