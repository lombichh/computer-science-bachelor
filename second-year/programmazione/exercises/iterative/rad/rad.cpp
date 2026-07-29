#include <iostream>
using namespace std;

int rad(int n) {
    int root = 0;
    int i;
    for(i = 0; i * i <= n; i++) {
        root = i;
    }
    return root;
}

int main() {
    cout << rad(26);

    return 0;
}