#include <iostream>

int main(){
        double x = 2;
        double z = 5;
        const double& y = x;
        x = 5;
        const double* const p = &x;
        p = &z;
}
