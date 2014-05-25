#include <iostream>
#include <string>

using namespace std;

struct pg{
  void ensure_requirements();

}
}

bool pg::ensure_requirements(){
  return sufficient_diskpace();
}

bool pg::sufficient_diskspace(bool regressionTesting = false){
  int spaceForCompiling = 100; // MB
  int spaceForInstallDir = 20;
  int spaceForEmptyDatabaseCluster = 35;
  int spaceForRegressionTests = 150;
  int netSpaceRequired;
  if(regressionTesting){
    netSpaceRequired =  spaceForCompiling + spaceForInstallDir + spaceForEmptyDatabaseCluster + spaceForRegressionTests;
  }else{
    netSpaceRequired =  spaceForCompiling + spaceForInstallDir + spaceForEmptyDatabaseCluster;
  }
}

  
