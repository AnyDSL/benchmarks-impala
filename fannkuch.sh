/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -pthread -falign-labels=8 fannkuchredux.gcc-3.c -o fannkuchredux.gcc-3.gcc_run 
rm fannkuchredux.gcc-3.c
0.12s to complete and log all make actions

COMMAND LINE:
./fannkuchredux.gcc-3.gcc_run 12

/usr/local/src/rust-0.11.0-i686-unknown-linux-gnu/bin/rustc --opt-level=3 fannkuchredux.rs -o fannkuchredux.rust_run
rm fannkuchredux.rs
3.90s to complete and log all make actions

COMMAND LINE:
./fannkuchredux.rust_run 12

MAKE:
mv fannkuchredux.ghc-5.ghc fannkuchredux.ghc-5.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts  fannkuchredux.ghc-5.hs -o fannkuchredux.ghc-5.ghc_run
[1 of 1] Compiling Main             ( fannkuchredux.ghc-5.hs, fannkuchredux.ghc-5.o )
Linking fannkuchredux.ghc-5.ghc_run ...
rm fannkuchredux.ghc-5.hs
1.69s to complete and log all make actions

COMMAND LINE:
./fannkuchredux.ghc-5.ghc_run  12
