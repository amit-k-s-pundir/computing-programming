#include <functional>
#include <boost/lambda/lambda.hpp>

#include <Sonu/Curl.hpp>

using namespace std;
using namespace boost::lambda;

struct Curl{
  Curl(){
    curl_global_init();
  }
  ~Curl(){
    curl_global_cleanup();
  }
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
    //  int setOptions(vector<CurlOptions> options; const string& url,
    //  function<R(Args...)> writeCallBack, 
  }
};

struct Doc{
  Doc(const char* name, cons char* download_dir = "/opt/downloads", const char* install_dir,
      const vector<string>& urls) 
    : name(name), downloadDir(dowffnloadDir), installDir(installDir){}
  const char* name, *downloadDir, *installDir;
  vector<string> urls;
  int update(){
    Curl curl;
    curl.init();
    curl.setOptions();
    curl.do();
  };
};

int main(int argc, char* argv[]){
  vector<Doc> docs = {Doc("Lisp", "/opt/downloads", "/home/sonu/programming_docs/lisp", {})};
  for(auto it = docs.begin(); it != docs.end(); it++){
    update(*it);
  }

  return 0;
}


