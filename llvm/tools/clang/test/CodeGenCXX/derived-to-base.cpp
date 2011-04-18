// RUN: %clang_cc1 %s -triple=x86_64-apple-darwin10 -emit-llvm -o - | FileCheck %s
struct A { 
  void f(); 
  
  int a;
};

struct B : A { 
  double b;
};

void f() {
  B b;
  
  b.f();
}

// CHECK: define %struct.B* @_Z1fP1A(%struct.A* %a) nounwind
B *f(A *a) {
  // CHECK-NOT: br label
  // CHECK: ret %struct.B*
  return static_cast<B*>(a);
}

// PR5965
namespace PR5965 {

// CHECK: define %struct.A* @_ZN6PR59651fEP1B(%struct.B* %b) nounwind
A *f(B* b) {
  // CHECK-NOT: br label
  // CHECK: ret %struct.A*
  return b;
}

}

