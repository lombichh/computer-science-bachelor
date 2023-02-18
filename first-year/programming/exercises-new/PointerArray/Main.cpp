#include <iostream>
using namespace std;

int main() {
    int A[10];
    int* p = &A[0];

    for (int i = 0; i < 10; i++) {
        cin >> *p;
        p += 1; // or p = &A[i]
    }

    for (int i = 0; i < 10; i++) cout << A[i] << ", ";

    return 0;
}