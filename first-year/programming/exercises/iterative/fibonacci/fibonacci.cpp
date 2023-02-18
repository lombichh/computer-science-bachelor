#include <iostream>
using namespace std;

int fib(int n) {
    if (n == 0) return 0;
    else if (n == 1) return 1;

    int back1 = 1;
    int back2 = 0;
    int result = 0;
    for (int i = 1; i < n; i++) {
        result = back1 + back2;
        back2 = back1;
        back1 = result;
    }

    return result;
}

int main() {
    cout << fib(10);

    return 0;
}