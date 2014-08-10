gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -mfpmath=sse -msse3 nbody.c -o nbody.gcc_run -lm
./nbody.gcc-4.gcc_run 50000000

rustc --opt-level=3 nbody.rs -o nbody.rust_run
./nbody.rust_run 50000000

ghc --make -fllvm -O2 -XBangPatterns -rtsopts -fexcess-precision nbody.hs -o nbody.ghc_run
./nbody.ghc_run  50000000
