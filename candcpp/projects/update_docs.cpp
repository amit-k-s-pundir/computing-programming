#include <functional>
#include <boost/lambda/lambda.hpp>

#include <Sonu/Curl.hpp>

using namespace std;
using namespace boost::lambda;

struct Curl{
  CURL* handle;
  template<class Option, class Value> setOption(tuple<Option, Value> option){
    curl_easy_setopt(handle, get<0>(option), get<1>(option));
  };
  template<class... Tuples> setOptions(tuple<Tuples...> options){
    int tupleSize = tuple_size<tuple<Tuples...>::value;
    for(int i = 0; i < tupleSize; ++i){
      setOption(get<i>(options));
    }
  };
  void init(){`
    curl_global_init(CURL_GLOBAL_ALL);
    int setOptions(vector<CurlOptions> options; const string& url, function<R(Args...)> writeCallBack, 

struct Doc{
  string name, url, download_dir, install_dir;
  int update(){
};

// template<class T> struct WithDir : T{
// }    

vector<path> dirStack;
path pushd(string newDir){
  dirStack.push_back(newdir);
};
path popd(){
  dirStack.pop_back();
};

template<class R, class... Args> auto withDir(const string& newDir, function<R(Args... args)> f, Args... args){
path originalDir = cwd();
pushd newDir;
auto r = f(args...);
popd;
}


template<class T> int update(const T& doc){
  doc.update();
};

int update(const Doc& doc){
 


int main(int argc, char* argv[]){
  for(auto it = docs.begin(); it != docs.end(); it++){
    update(*it);
  }
  withDir::apply<f>::type v;
v.
  return 0;
}


