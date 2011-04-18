#include <iostream>
#include <vector>

using namespace std;
int main(int argc, char **argv) {
    std::cout << "Hello, world!" << std::endl;
    std::vector<int> v;
    v.push_back(5);
    cout << "Vector now contains " << v.size() << "elements.\n";
    return 0;
}
