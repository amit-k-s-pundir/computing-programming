/*
 * =====================================================================================
 *
 *       Filename:  daily_compile_jobs.cpp
 *
 *    Description:  Takes a list of program names and compiles each of those if it knows how. Also
 *    maintains a default list of programs and sufficient information to compile them.  Helps heating.
 *
 *        Version:  1.0
 *        Created:  Friday 10 December 2010 12:34:55  IST
 *       Revision:  none
 *       Compiler:  gcc
 *
 *         Author:  YOUR NAME (), 
 *        Company:  
 *
 * =====================================================================================
 */
#include <vector>
#include <string>
#include <iostream>
#include <sstream>
#include <functional>
#include <algorithm>

#include <stdlib.h>

#include <boost/foreach.hpp>

using namespace std;

std::vector<string> default_jobs = {"sbcl", "ecl",  "racket", "chicken",
"gambit"};

vector<string> jobScripts;

BOOST_FOREACH(string script, jobScripts){
        launchShell(script);
}

void launchShell(string shellCommands){
  string commandString = "/bin/bash -c \"" + shellCommands + "\"";
  system(commandString);
}

int void main(int argc, char* argv[]){
  stringstream s;
  // sbcl
  