#include <iostream>
#include <map>
#include<initializer_list>

using namespace std;

int y = 5;
class Test{
private:
  const static int x = 7;
};

int main(int argc, char* argv[]){
  int x = 2;
  const int& y = x;
  x = 5;

  const map<string,string>& m({{"first","sonu"},{"sirname","pundir"}});
  //= map<string,string>({{"first","sonu"},{"sirname","pundir"}});

  cout << "x: " << x << "\n";
  cout << "y: " << y << "\n";

  return 0;
}
  
