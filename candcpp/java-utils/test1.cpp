#include <iostream>
#include <string>
#include <fstream>
#include <sstream>
using namespace std;

int main(int argc, char* argv[]){
        /*
        string& s(5);
        const string& t = s;
        cout << "s: " << s << "\n";
        cout << "t: " << t << "\n";
        t += "s";
        cout << "s: " << s << "\n";
        cout << "t: " << t << "\n";
*/
       stringbuf test_buf;
       string&& str("pundir"); //= test_buf.str();
       ostringstream sstrm(str);
       sstrm << "sonu" << "\n";
       str = sstrm.str();
       cout << str << "\n";

        return 0;
}
