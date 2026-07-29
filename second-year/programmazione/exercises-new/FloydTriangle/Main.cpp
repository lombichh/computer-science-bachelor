#include <iostream>
using namespace std;

int main() {
    int x;
    cin >> x;

    int row = 1;
    int firstNumber = 1;
    while (row <= x) {
        int firstNumberSucc = firstNumber + row;
        for (int i = 0; i < firstNumberSucc; i++) cout << firstNumber + row << " ";
        cout << endl;
        row++;
    }

    return 0;
}