#include <stdio.h>
#include <stdlib.h>

void main_impala();

int main() {
    main_impala();
}

void print_char(char c) {
   printf("%c\n", (int)c);
}
void print_int(int i) {
   printf("%d\n", i);
}
void print_f64(double d) {
   printf("%.9f\n", d);
}

void println() {
   printf("\n");
}

void printa(char* a) {
   printf("%d %d %d %d %d\n", a[0], a[1], a[2], a[3], a[4]);
}

void print_piece_mask(unsigned long long* a) {
    for (int i = 0; i < 12; ++i)
        printf("%lli ", a[i]);
    printf("\n");
}

void print_piece_def(char* a) {
    for (int i = 0; i < 40; ++i)
        printf("%d ", a[i]);
    printf("\n");
}

// header for mandelbrot bitmap
void print_header(int w, int h) {
   printf("P4\n%d %d\n",w,h);
}

void put_i8(char c) {
   putc(c, stdout);
}

void* thorin_malloc(size_t size) { 
    void* p;
    posix_memalign(&p, 64, size);
    return p;
}

// meteor printing
void print_meteor_scnt(int cnt) {
   printf("%d solutions found\n\n", cnt);
}

void print_meteor_lines(char a0, char a1, char a2, char a3, char a4, char a5, char a6, char a7, char a8, char a9) {
   printf("%c %c %c %c %c \n %c %c %c %c %c \n", a0+'0', a1+'0', a2+'0', a3+'0', a4+'0', a5+'0', a6+'0', a7+'0', a8+'0', a9+'0');
}

void write(const char* line, size_t size) {
    fwrite(line, size, 1, stdout);
}

void print(const char* s) {
    fputs(s, stdout);
}
