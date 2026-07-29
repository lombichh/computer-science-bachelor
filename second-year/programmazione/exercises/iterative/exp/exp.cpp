#include <iostream>
#include <cmath>
using namespace std;

int factorial(int x) {
    int result;

    if (x == 0) result = 1;
    else {
        result = x;
        for (int i = 2; i < x; i++) result *= i;
    }

    return result;
}

int approx_exp(int x, int n) {
    int result = 0;
    for (int i = 0; i < n; i++) {
        int power = 1;
        for (int j = 0; j < i; j++) {
            power *= x;
        }

        result += power / factorial(i);
    }

    return result;
}

int main() {
    cout << "Esponenziale approssimato: " << approx_exp(6, 30)
        << endl << "Esponenziale non approssimato: " << exp(6);

    return 0;
}