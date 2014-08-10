MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -fopenmp regexdna.gcc-2.c -o regexdna.gcc-2.gcc_run -lpcre
rm regexdna.gcc-2.c
0.14s to complete and log all make actions

COMMAND LINE:
./regexdna.gcc-2.gcc_run 0 < regexdna-input5000000.txt


MAKE:
/usr/local/src/rust-0.11.0-i686-unknown-linux-gnu/bin/rustc --opt-level=3 regexdna.rs -o regexdna.rust_run
regexdna.rs:77:27: 77:54 warning: use of deprecated item: obsolete, use `to_string`, #[warn(deprecated)] on by default
regexdna.rs:77         variant_strs.push(variant.to_str().to_owned());
                                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~
rm regexdna.rs
15.51s to complete and log all make actions

COMMAND LINE:
./regexdna.rust_run 0 < regexdna-input5000000.txt


MAKE:
mv regexdna.ghc-2.ghc regexdna.ghc-2.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts  regexdna.ghc-2.hs -o regexdna.ghc-2.ghc_run
[1 of 1] Compiling Main             ( regexdna.ghc-2.hs, regexdna.ghc-2.o )
Linking regexdna.ghc-2.ghc_run ...
rm regexdna.ghc-2.hs
1.77s to complete and log all make actions

COMMAND LINE:
./regexdna.ghc-2.ghc_run +RTS -H250M -RTS 0 < regexdna-input5000000.txt
