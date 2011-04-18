// =====================================================================================
// 
//       Filename:  test.cpp
// 
//    Description:  
// 
//        Version:  1.0
//        Created:  Wednesday 24 March 2010 06:31:46  IST
//       Revision:  none
//       Compiler:  g++
// 
//         Author:  Amit Pundir (amit_pundir), sonupundir@gmail.com
//        Company:  
// 
// =====================================================================================

#include <iostream>
#include <string>

using namespace std;

int main(int argc, char* argv[]){
        const string& s = "sonu";
        cout << "s is: " << s << "\n";
        s.assign("t");
        cout << "now s is: " << s << "\n";
        const string& t = s;
        cout << "t is: " << t << "\n";
        const string& u = "pundir";
        cout << "u is: " << u << "\n";

        return 0;
}
