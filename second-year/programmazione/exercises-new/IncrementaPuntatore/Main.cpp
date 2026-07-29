#include <iostream>
using namespace std;

int main() {
    int x = 1;

    typedef int* pint;
    pint p, q;

    p = &x;
    q = &x;

    *p += 1;
    *q += 1;

    cout << x;

    return 0;
}