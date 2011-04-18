#include "boost/filesystem.hpp"
#include "boost/program_options.hpp"

#include <iostream>

namespace po = boost::program_options;
using boost::filesystem;

int main(int argc, char* argv[]){
  po::options_description desc("Allowed options");
  desc.add_options()
	("help", "produce help message")
	//("backup-type", po::value<string>()->default_value("configs-and-dots"),
	//"What type of backup do you want?");
	("files,f", value<vector<string> >()->composing(), "files to be backed up")
	("dir,d", value<vector<string> >()->composing(), "directories to be backed up");

  variables_map vm;

  store(command_line_parser(argc, argv).options(desc).extra_parser(regex_parser)
		.run(), vm);

  if(vm.count("help")){
	cout << desc << "\n";
  }

  if(vm.count("config-file"){
	  // Load the file and parse it.
	  ifstream ifs(vm["config-file"].as<string>().c_str());
	  if(!ifs){
		cout << "Could not open the configuration file"

  po::variables_map vm;
  po::store(po::parse_command_line(argc, argv, desc), vm);
  po::notify(vm);

  
  
  return 0;
}
