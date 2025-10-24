#include <iostream>
using namespace std;

int log(int n) {
    int result = 0;
    for (int mult = 1; mult * 2 <= n; mult *= 2) {
        result++;
    }
    return result;
}

int main() {
    cout << log(32);

    return 0;
}