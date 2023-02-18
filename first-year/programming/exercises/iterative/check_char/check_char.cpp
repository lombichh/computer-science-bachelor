#include <iostream>
using namespace std;

int main() {
    char c;
    cout << "Insert a character: ";
    cin >> c;

    while (c != 'q') {
        if (c >= '0' && c <= '9') {
            cout << "The next number is: " 
                << (char) (c + 1) << endl;
        }

        cout << "Insert a character: ";
        cin >> c;
    };


    return 0;
}