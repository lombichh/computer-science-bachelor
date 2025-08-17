#include <iostream>
using namespace std;

int main() {
    int height;
    cout << "Insert the height of the tree: ";
    cin >> height;

    int base = (height * 2) - 1;
    for (int i = 1; i <= base; i += 2) {
        for (int j = 0; j < (base - i) / 2; j++) cout << ' ';
        for (int j = 0; j < i; j++) cout << '*';
        cout << endl;
    }

    return 0;
}