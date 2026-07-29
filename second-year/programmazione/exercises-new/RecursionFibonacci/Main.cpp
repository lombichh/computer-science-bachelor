#include <iostream>
using namespace std;

int fib(int n, int i, int l) {
    if (n == 0) return l;
    else return fib(n, i + l, i);
}

int main() {
    cout << fib(10, 1, 0);

    return 0;
}