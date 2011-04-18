#include <iostream>
#include <curl/curl.h>

int main(int argc, char** argv){
  CURL* easyhandle;
  CURLcode res;
  curl_global_init(CURL_GLOBAL_ALL);
  easyhandle = curl_easy_init();
  if(easyhandle){
	curl_easy_setopt(easyhandle, CURLOPT_URL, "http://www.google.com/");
	//  size_t write_data(void* buffer, size_t size, size_t nmemb, void* userp);
	//  curl_easy_setopt(easyhandle, CURLOPT_WRITEFUNCTION, write_data);
	//  curl_easy_setopt(easyhandle, CURLOPT_WRITEDATA, &internal_struct);
	success = curl_easy_perform(easyhandle);

	curl_easy_cleanup(curl);
  }
}
