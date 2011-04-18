#include "boost/filesystem.hpp"
#include <xercesc/util/PlatformUtils.hpp>

#include <iostream>
using namespace std;
using namespace xercesc;
using boost::filesystem;

int main(int argc, char** argv){

   try {
    XMLPlatformUtils::Initialize();
  }
  catch (const XMLException& toCatch) {
    // Do your failure processing here
    return 1;
  }

   // Do your actual work with Xerces-C++ here.
  path testPath("/home/sonu/workspace/testdir/");

  curl_global_init(CURL_GLOBAL_SSL);
  easyHandle = curl_easy_init();
  curl_easy_setopt(easyHandle, CURLOPT_URL, "http://www.google.com/");

  XMLPlatformUtils::Terminate();

  // Other terminations and cleanup.
  return 0;
}
