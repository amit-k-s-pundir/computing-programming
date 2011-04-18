#include <string>
#include <iostream>

#include <boost/filesystem.hpp>

using namespace std;
namespace fs = boost::filesystem;
  
namespace tc{
  class Project{
   string name;
   fs::path base_dir;
   
   