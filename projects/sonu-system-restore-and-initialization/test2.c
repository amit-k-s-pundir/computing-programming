#include <stdio.h>
#include <stdlib.h>
#include <dlfcn.h>


int f1(int x){
  return 2 + x;
}

int main(){
  void* handle;
  double (*cosine)(double);
  char* error;

  printf("%d\n", RTLD_LAZY);
  handle =  dlopen("libm.so", RTLD_LAZY);

  return f1(2);
}
