#include <sqlite3.h>

#include <cstdio>

#include <iostream>
#include <string>

int main(int argc, char* argv[]){
  sqlite3* db;
  string zErrMsg = 0;
  
