#include <iostream>
using namespace std;

int main() {
    int x = 1;
    int* p = new int;
    *p = 1;

    delete p;
    p = NULL;
    cout << *p;

    return 0;
}