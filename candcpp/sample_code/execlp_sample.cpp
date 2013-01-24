#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <string>

using namespace std;

template<class P, class... A> pid_t runProcess(P& p, A&... args);

template<> pid_t runProcess<string, string>(string& processName, string& processArg){
  pid_t cpid = fork();
  if(0 == cpid){
    execlp(processName.c_str(), processName.c_str(), processArg.c_str(), NULL);
    //execlp("gvim", "gvim", NULL);
    
  }else{
    int status;
    wait(&status);
    return cpid;
  }
};

int main(int argc, char* argv[])
{
  string s("gvim"), t("./test.txt");
  runProcess<string, string>(s, t);
  return 0;
}
