#include <iostream>
#include <fstream>
#include <string>

#include <boost/xpressive/xpressive.hpp>

using namespace boost::xpressive;

int main(int argc, char** argv){
  // std::string hello("hello world!");

  // sregex rex = sregex::compile("(\\w+) (\\w+)!");
  // smatch what;

  // if(regex_match(hello, what, rex)){
  // 	std::cout << what[0] << "\n"; // whole match
  // 	std::cout << what[1] << "\n"; // first capture
  // 	std::cout << what[2] << '\n'; // second capture
  // }

  /*         Code Sample Begin                 */

  /*
	std::string input("This is his face");
	sregex re = as_xpr("his");                // find all occurrences of "his" ...
	std::string format("her");                // ... and replace them with "her"

	// use the version of regex_replace() that operates on strings
	std::string output = regex_replace( input, re, format );
	std::cout << output << '\n';

	// use the version of regex_replace() that operates on iterators
	std::ostream_iterator< char > out_iter( std::cout );
	regex_replace( out_iter, input.begin(), input.end(), re, format );
  */

/* Code Sample End */
 
//  const std::string& current_grub_file("grub.conf");
  const char* current_grub_file = "grub.conf";
  //  const std::string& new_grub_file("grub.conf.new");
   const char* new_grub_file = "grub.conf.new";
  std::string current_ver(argv[2]);
  std::string next_ver(argv[3]);
  std::string iline;

  sregex re = sregex::compile(current_ver);
  smatch what;

  std::ifstream is(current_grub_file);
  std::ofstream os(new_grub_file);

  while(getline(is, iline)){
	  //	std::string iline;
	  //	is.getline(iline);
	if(regex_search(iline, what, re)){
		std::string modified_iline = "# " + iline;
		os << modified_iline << "\n";
		std::string oline = regex_replace(iline, re, next_ver);
		os << oline << "\n";
	  }else{
		os << iline << "\n";
	  }
  }

  return 0;
}
