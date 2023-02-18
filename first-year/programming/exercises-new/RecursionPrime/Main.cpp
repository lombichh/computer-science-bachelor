#include <iostream>
using namespace std;

bool isPrime(int n, int div) {
    if (div > n / 2) return true;
    else {
        if (n % div == 0) return false;
        else return isPrime(n, div + 1);
    }
}

int main() {
    cout << isPrime(1, 2);

    return 0;
}