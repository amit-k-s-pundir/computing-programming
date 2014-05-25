#include <curl/curl.h>

#include <iostream>
#include <vector>
#include <string>
#include <cstdlib>

using namespace std;

void setOption(void* symbolAddress, void* value, void* default){
  if(symbolAddress){
    if(value){
      *symbolAddress = *value;
    }else{
      *symbolAddress = *default;
      }
  }
}

int main(int argc, char* argv[]){
//    using namespace std;
  
  vector<string> urls;
  urls.push_back("one");
  urls.a
  int no_of_fork_children = argv[1];
  div_t result = div(urls.size(), no_of_fork_children);
  for(int i = 0; i < result.quot; ++i){
    for(int j = i * no_of_fork_children; j < (i * no_of_fork_children); ++j){
      cout << j << "\n";
      }
    }
  cout << "yeah, running" << "\n";
  cout << urls.at(0) << endl;
  return 0;
  }
//  for(int &i : urls){
    
//  int quotient = urls.size();
