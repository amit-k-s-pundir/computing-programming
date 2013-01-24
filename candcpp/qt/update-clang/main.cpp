#include <QCoreApplication>
#include <vector>

using namespace std;
get_required_tools();
checkout_llvm();
checkout_clang();
checkout_extra_clang_tools();
checkout_compiler_rt();


struct Clang{
        void build(){
            get_required_tools();
            checkout_llvm();
            checkout_clang();
            checkout_extra_clang_tools();
            checkout_compiler_rt();

        }

        void build_llvm(){
        }
}

struct llvm{
        void build(){}
}
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    
    return a.exec();
}
