MAKE:
/usr/bin/gcc -pipe -Wall -O3 -fomit-frame-pointer -march=native -std=c99 -mfpmath=sse -msse3 fasta.gcc-5.c -o fasta.gcc-5.gcc_run 
rm fasta.gcc-5.c
0.11s to complete and log all make actions

COMMAND LINE:
./fasta.gcc-5.gcc_run 25000000
