#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

#include <string>
#include <vector>
#include <iostream>

using namespace std;

//template<class P, class... A> pid_t runProcess(P& p, A&... args);
int main(int argc, char* argv[])
{
  vector<string> v = {"hello", "world"};
  for(string& s : v){
    cout << s << endl;
  };
  return 0;
}
