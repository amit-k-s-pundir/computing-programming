#include <initializer_list>
#include <vector>
#include <string>

using namespace std;

typedef struct{
        int x;
        vector<string> y;
} T;

int main(){
        T t {2, vector<string> {"sonu", "pundir"}};

        return 0;
}
