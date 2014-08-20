#include <stdio.h>

int main_impala();

int main() {
    main_impala();
}

void print_int(int i) {
   printf("%d\n", i);
}
void print_f64(double d) {
   printf("%.9f\n", d);
}

// header for mandelbrot bitmap
void print_header(int w, int h) {
   printf("P4\n%d %d\n",w,h);
}

void put_i8(char c) {
   putc(c, stdout);
}
