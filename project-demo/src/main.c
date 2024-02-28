#include <stdio.h>
#include "main.h"

int main(void) {
  int a = 2;
  int b = 3;
  int c = add(a, b);
  printf("The sum of %d and %d is %d\n", a, b, c);
  return 0;
}
