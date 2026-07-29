#include <iostream>
#include <cstring>
#include <cmath>

class test_class {
public:
    int n;

    test_class(int num = 7) {
        n = num;
    }
};

int main() {
    test_class a = test_class(5);
    test_class *c = &a;
    delete c;
    c = NULL;
    std::cout << 4;
    using namespace std;
    cout << 3;
    
    return(0) ;
}