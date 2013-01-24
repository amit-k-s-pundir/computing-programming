#include <unistd.h>
#include <stdlib.h>

#include <initializer_list>
#include <iostream>
#include <string>

#include "boost/asio.hpp"
#include "boost/chrono.hpp"

using namespace std;
using namespace boost;

class Supervisor{
public:
  Supervisor();
  void runProcess(Process process, Duration duration, int freq);
  void runProcessInGroups(vector<string> processList, int groupSize);
  
};

void Supervisor::run_process(Process process, Duration duration, int freq){
  pid_t pid = fork();
  (if 0 == pid){// we are in child
  }else{// we are in the parent
  }
}

void Supervisor::runProcessInGroups(vector<string> processList, int groupSize){
  div_t result = div(processList.size(), groupSize);
  
  for(int i = 0; i < result.quot; ++i){
    for(int j = i * groupSize; j < (i + 1) * groupSize; ++j){
      runProcessGroup(
