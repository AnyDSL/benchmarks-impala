MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -std=c99 -D_GNU_SOURCE -mfpmath=sse -msse2 -fopenmp mandelbrot.gcc-2.c -o mandelbrot.gcc-2.gcc_run 
mandelbrot.gcc-2.c: In function ‘main’:
mandelbrot.gcc-2.c:23:5: warning: implicit declaration of function ‘atoi’ [-Wimplicit-function-declaration]
     w = h = atoi(argv[1]);
     ^
rm mandelbrot.gcc-2.c
0.08s to complete and log all make actions

COMMAND LINE:
./mandelbrot.gcc-2.gcc_run 16000
MAKE:
mv mandelbrot.ghc-2.ghc mandelbrot.ghc-2.hs
/usr/local/src/ghc-7.8.2/bin/ghc --make -fllvm -O2 -XBangPatterns -rtsopts -fexcess-precision mandelbrot.ghc-2.hs -o mandelbrot.ghc-2.ghc_run
[1 of 1] Compiling Main             ( mandelbrot.ghc-2.hs, mandelbrot.ghc-2.o )
Linking mandelbrot.ghc-2.ghc_run ...
rm mandelbrot.ghc-2.hs
1.62s to complete and log all make actions

COMMAND LINE:
./mandelbrot.ghc-2.ghc_run  16000