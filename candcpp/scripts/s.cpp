#include <iostream>
#include <functional>
#include <unistd.h>
#include <string>
#include <sys/types.h>
#include <sys/wait.h>
#include <errno.h>
#include <stdlib.h>
#include <stdio.h>

//boost stuff
#include "boost/filesystem/operations.hpp"
#include "boost/filesystem/path.hpp"
#include "boost/progress.hpp"

namespace fs = boost::filesystem;

int main(int argc, char** argv){
  fs::path projects_path("~/workspace/projects");
  fs::path tc_path("~/workspace/projects/tc");
  fs::path tc_projs_archs_path("~/workspace/projects/tc/architecture");
  fs::path tc_projs_assembly_path("~/workspace/projects/tc/assembly");
  //Sample code:
  /*  remove_all( "foobar" );
    create_directory( "foobar" );
    ofstream file( "foobar/cheeze" );
    file << "tastes good!\n";
    file.close();
    if ( !exists( "foobar/cheeze" ) )
      std::cout << "Something is rotten in foobar\n";
  */
  //End sample code.


  
  
}
