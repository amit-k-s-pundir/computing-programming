#include "tc_tool.cpp"

int main(int argc, char **argv) {
  //CURL* eh = curl_easy_init();
  const string
  url("http://www.topcoder.com/tc?module=ViewActiveContests&ph=112");
  CURL* conn = NULL;
  CURLcode code;
  
  curl_global_init(CURL_GLOBAL_DEFAULT);
  
  if(!init(conn, url.c_str())){
    std::cerr << "Connection initialization failed." << "\n";
    exit(EXIT_FAILURE);
  }
  
  curl_easy_perform(conn);
  
  std::cout << buffer << "\n";
  std::cout << std::string(errorBuffer) << "\n";
  
  curl_easy_cleanup(conn);
  
  parseHtml(buffer, title);
  //  getAndShowDesProjs();
  return EXIT_SUCCESS;
}
