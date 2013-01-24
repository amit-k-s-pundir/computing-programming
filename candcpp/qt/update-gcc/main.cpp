#include <QCoreApplication>
#include <string>
#include <vector>
#include <iostream>
#include "dir-utils.h"
#include <curl/curl.h>

namespace fs = boost::filesystem;

using namespace std;
using namespace fs;

struct GccPrerequisites{
        string version, url;
        DirTree dir_tree({dir, {}, {"build", "install"}});
}

bool download_gcc(){
  CURL* curl = curl_easy_init();
  CURLcode res;
  if(curl){
                  curl_easy_setopt(curl, CURLOPT_URL, url);
                  res = curl_easy_perform(curl);
                  curl_easy_cleanup(curl);
          }else{
                  cerr << "Couldn't initialize curl; failed to bet the (CURL*)"
                       << " handle" << endl;
    }
  curl_global_cleanup();
  return res;
}


bool unarchive_gcc(){
        return true;
}

bool update_gcc(GccPrerequisites prereqs){
  with_dir(dirtree, [](const string & s){
                  ensure_dirtree(dirtree);});
  with_dir(work_dir, [](const string & s) {
      if(!fs::exists(gcc_archive))
        {download_gcc_archive();}
      else{unarchive_gcc()}});
  with_dir(build_dir, [](const string & s){
                  build_gcc();
                  install_gcc();});

  return true;
}

int main(int argc, char *argv[])
{
  QCoreApplication a(argc, argv);

  string gcc_version, base_dir("/opt/sources/gcc"), work_dir,
                  download_url;
  ensure_dir_tree(
  if(!dependenies_satisfied()){
                  fulfill_dependencies();
          }
  with_dir(work_dir, )
  
  return a.exec();
}
