#include <string>
#include <iostream>
#include <vector>
#include <algorithm>

#include <unistd.h>
#include <cstdlib>
#include <cstdarg>
#include <sys/types.h>
#include <sys/wait.h>


using namespace std;

//template<class P, class... A> pid_t runProcess(P& process, A&... processArgs);

pid_t runProcess(const string& processName, initializer_list<string>& processArgs){
  pid_t cpid = fork();
  if(0 == cpid){
    execlp(processName.c_str(), processName.c_str(), processArgs, NULL);
  }else{
    int status;
    wait(&status);
    return cpid;
  }
};

struct Process{
  const char* name;
   char* args[];
};

pid_t runProcess(const Process& process){
  pid_t cpid = fork();
  if(0 == cpid){
    execv(process.name, process.args);
  }else{
    int status;
    wait(&status);
    return cpid;
  }
};
    
// template <> pid_t runProcess<ProcessFunction, ProcessFunctionArgs>(ProcessFunction& fn, ProcessFunctionArgs& args){
//   //  int status;
//   pid_t cpid = fork();
//   if(0 == cpid){// we are in the child process
//     fn(args);
//   }else{// we are the parent process
//     //    waitpid(cpid, &status
//     return cpid;
//   }
// };

int runProcesses(const vector<Process>& processes){
  for(auto it = processes.begin(); it != processes.end(); it++){
    runProcess(*it);
  }
};

template<class... Functions, class... Args> int runProcesses
template<class... Functions, class... Args> int runProcessess(tuple<Functions...>& processFunctions, tuple<ProcessFunctionsArgs& processFunctionArgs){
  int size = ProcessFunctions::size;
  if(processFunctionArgs::size != size) throw("The number of functions and the number of args should be same");
  for(int i = 0; i <= size; ++i){
    auto fn = get<decltype(processFunctions)>(i);
    auto args = get<decltype(processFunctionArgs)>(i);
    runProcess(fn, args);
  }
  
  // int i = 0;
  // (for f& : processFunctionList){
  //   f->apply(processArgs[i]);
  //   i++;
  // }
};

int runProcessGroup(processFunctions& processFunctions, ProcessFunctionsArgs& processFunctionsArgs, int groupSize){
  int totalSize = processFunctions.size();
  div_t result = div(totalSize, groupSize);
  for(int i = 0; i < result.quot; i++){
    vector<int> cpids;
    for(int j = 0; j < groupSize; j++){
      int index = i * groupSize + j;
      cpids.push_back(runProcess(get<index>(processFunctions), get<index>(processFunctionsArgs)));
    }
    //wait till all the child processess have successfully finished
    int status, w;
    while(w = waitpid(-1, &status, WOUNTRACED | WCONTINUED)){
      if(-1 == w){
        perror("waitpid");
        exit(EXIT_FAILURE);
      }
    }
  }
};

// template<class R, class... Args> R doInGroups(function<R(Args... args)> f, int groupSize, int totalSize){
//   div_t result = div(totalSize, groupSize);
//   int numberOfGroups = result.quot 
   
//   for(

int main(int argc, char* argv[]){
  //  apply<F, ArgList>(f, argList);
  
  return 0;
}

