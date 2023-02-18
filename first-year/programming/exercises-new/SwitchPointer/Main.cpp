#include <iostream>
using namespace std;

typedef int* pint;

void scambia(pint p, pint q) {
    pint tmp;
    *tmp = *p;

    *p = *q;
    *q = *tmp;
}

int main() {
    int x = 1, y = 2;

    pint p, q;
    p = &x;
    q = &y;

    cout << x << ", " << y << endl;

    scambia(p, q);

    cout << x << ", " << y;

    return 0;
}