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
#include "boost/spirit/include/include"

namespace fs = boost::filesystem;

namespace tc{

  class Design{
  public:
	string name;
	fs::path baseDir("/home/sonu/workspace/projects/tc/design");

	Design(const string& name, const fs::path & baseDir){
	}

	setup(){
	  // Setup the directory tree.
	  
  }
}
template<class ProjectType> class Project{
public:
  
  typedef T ProjectT;
  typedef fs::path BaseDirT;
  typedef string URL;
  typedef string DateT;

  ProjectT project;
  string name;
  BaseDirT basDir;// = project.baseDir;
  DateT dueDate;
  
  Project(const T & project, const string & name, const fs::path & baseDir,
		  const string & URL, const string & startDate) : project(project),
		  name(name), baseDir(project.baseDir);

  setup(){
	// Create directory structure for the project.
	// First delegate to the *project* to let it do its setup.
	project.setup();
  }
}

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
  create<Project<TC::Design> >(  
}
