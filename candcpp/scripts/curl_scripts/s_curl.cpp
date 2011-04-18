#include <iostream>
#include <curl/curl.h>

bool download(const URL& url, const Regex& link_regex) const{
  
}

int main(int argc, char* argv[]){
        if(CURLcode res = curl_global_init(CURL_GLOBAL_ALL)){
                cerr << "Unable to initialize libcurl!" << "\n";
        }

        CURL* easy_handle = curl_easy_init();
  //Downloads all links that match the regex 'link_regex' from the url 'url'.
  download(url, link_regex);

  curl_global_cleanup();
}
