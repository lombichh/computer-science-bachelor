#include <iostream>
#include <cstring>
using namespace std;

void upperCase(char str[], int length) {
    for (int i = 0; i < length; i++) {
        if (str[i] >= 'a' && str[i] <= 'z') {
            str[i] -= 32;
        }
    }
}

int main() {
    const int length = 10;
    char str1[10];
    cin.getline(str1, length);

    upperCase(str1, length);

    cout << str1;

    return 0;
}