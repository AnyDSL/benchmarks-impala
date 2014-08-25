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

#define E     0
#define ESE   1
#define SE    2
#define S     3
#define SW    4
#define WSW   5
#define W     6
#define WNW   7
#define NW    8
#define N     9
#define NE    10
#define ENE   11
#define PIVOT 12
int mshift(int cell, int dir) {
   switch(dir) {
      case E:
         return cell + 1;
      case ESE:
         if((cell / 5) % 2)
            return cell + 7;
         else
            return cell + 6;
      case SE:
         if((cell / 5) % 2)
            return cell + 6;
         else
            return cell + 5;
      case S:
         return cell + 10;
      case SW:
         if((cell / 5) % 2)
            return cell + 5;
         else
            return cell + 4;
      case WSW:
         if((cell / 5) % 2)
            return cell + 4;
         else
            return cell + 3;
      case W:
         return cell - 1;
      case WNW:
         if((cell / 5) % 2)
            return cell - 6;
         else
            return cell - 7;
      case NW:
         if((cell / 5) % 2)
            return cell - 5;
         else
            return cell - 6;
      case N:
         return cell - 10;
      case NE:
         if((cell / 5) % 2)
            return cell - 4;
         else
            return cell - 5;
      case ENE:
         if((cell / 5) % 2)
            return cell - 3;
         else
            return cell - 4;
      default:
         return cell;
   }
}
