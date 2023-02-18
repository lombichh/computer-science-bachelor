#include <iostream>
using namespace std;

bool is_prime(int n) {
    bool prime = true;
    int i = 2;
    while (i <= (n / 2) && prime) {
        if (n % i == 0) prime = false;
        else i++;
    }

    return prime;
}

int main() {
    int n;
    cout << "Insert a number: ";
    cin >> n;

    while (n != 0) {
        if (is_prime(n)) cout << n << " is a prime number" << endl;
        else  cout << n << " is not a prime number" << endl;

        cout << "Insert a number: ";
        cin >> n;
    }

    return 0;
}