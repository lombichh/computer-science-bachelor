#include <iostream>
using namespace std;

int sqrt(int x) {
    int sqrt_value = 0;
    while ((sqrt_value + 1) * (sqrt_value + 1) <= x) sqrt_value++;
    
    return sqrt_value;
}

int main() {
    int x, y;
    cout << "Insert the value of the two sides: ";
    cin >> x >> y;

    cout << "The hypotenuse of the triangle is: " << sqrt(x*x + y*y);
}