#include <iostream>
using namespace std;

int main() {
    int x, y;
    cout << "Insert two numbers: ";
    cin >> x >> y;

    // using third variable
    int z = x;
    x = y;
    y = z;

    cout << "Switched numbers using third var: "
        << x << ", " << y << endl;

    // without using third variable
    x = x + y;
    y = x - y;
    x = x - y;

    cout << "Switched numbers without using third var: "
        << x << ", " << y;
}