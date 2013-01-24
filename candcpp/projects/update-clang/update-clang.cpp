#include <iostream>

using namespace std;

bool update_clang(){
  ensure_required_tools();
  checkout_llvm();
  checkout_clang();
  checkout_clang_extra();
  checkout_compiler_rt();
  build_llvm();
  build_clang();
  
  return true;
}


