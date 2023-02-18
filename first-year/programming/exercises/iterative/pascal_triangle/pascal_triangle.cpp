#include <iostream>
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

int get_pascal_num(int row, int col) {
    return factorial(row) / (factorial(col) * factorial(row - col));
}

void pascal_triangle(int n) {
    for (int row = 0; row < n; row++) {
        for (int i = 0; i < (n - (row + 1)); i++) {
            cout << "  ";
        }

        for (int col = 0; col < row + 1; col++) {
            cout << get_pascal_num(row, col) << "  ";
        }

        cout << endl;
    }
}

int main() {
    pascal_triangle(10);

    return 0;
}