#include <QCoreApplication>
#include <vector>
#include <boost/filesystem.hpp>

#include <cstdlib>

using namespace std;

struct Llvm{
        string baseDir, installDir, workDir;

        void checkout(const string& baseDir, const string & downloadURL
                      =  "http://llvm.org/svn/llvm-project/llvm/trunk"){
            with_dir(baseDir, [](const string & baseDir){
                        string cmd = "svn co " + downloadURL + " " + installDir;
                        system(cmd);
            });
        }

        void build(){
                //Currently this will also build the clang.
                Clang(this).build(true);
        }

};

struct Clang{
    Llvm llvm;
    string installDir;

    Clang(Llvm* llvm) : llvm(llvm){

    }

    void checkout(const string & url =
            "http://llvm.org/svn/llvm-project/cfe/trunk", downloadDir
                  = "clang"){
        with_dir(llvm.installDir + "/tools", [](const string & llvmDir){
            //                    string baseDir = llvmDir + "/tools";
            string cmd = "svn co " + url + " " + downloadDir;
            system(cmd);
        });
    }

    void checkout_extra(const string & url =
            "http://llvm.org/svn/llvm-project/clang-tools-extra/trunk"){
        with_dir(installDir + "/tools", [](const string & clangExtraToolsDir){
            string cmd = "svn co " + url + " " + "extra";
            system(cmd);
        });
    }

    void checkout_compiler_rt(const string & url =
            "http://llvm.org/svn/llvm-project/compiler-rt/trunk"){
        with_dir(llvm.installDir + "projects", [](){
            string cmd = "svn co " + url + " " + "compiler-rt";
            system(cmd);
        });
    }

    void build(bool firstTime = true){
            string buildDir = "./build";
            if(firstTime){
                    if(!exists(buildDir)){
                        mkdir(buildDir);
                    }

                    with_dir(buildDir, [](){
                        // This builds both LLVM and clang for debug mode.
                        // Note: For subsequent Clang development, you can just do
                        // make at the clang directory level.
                        string cmd = "../llvm/configure && make";
                        system(cmd);
                    });
            }else{
                    with_dir(clangDir, [](){
                            string cmd = "make";
                            system(cmd);
                    });
            }
    }

    void update(bool firstTime){
        //        bool neverBeenBuildBefore = true;
        ensure_required_tools();
        Llvm::checkout();
        checkout();
        checkout_extra();
        checkout_compiler_rt();
        build();
        //            if(neverBeenBuildBefore){
        //            }else{
        //            }
        //    }
    }

    void get_required_tools(){
        /**
          Currently we are just installing the clang-dev package on linux to
          satisfy all the requirements.
          **/
    }

    bool ensure_required_tools(){
            return true;
    }
}

int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);
    
    return a.exec();
}
