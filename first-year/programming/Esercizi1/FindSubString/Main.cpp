#include <iostream>
#include <cstring>
using namespace std;

bool findSubString(char str[], char substr[], int length) {
    int i = 0;
    bool j = 0;
    bool found = false;
    while (i < length && !found) {
        if (substr[j] == '\0') found = true;
        else if (str[i] == substr[j]) j++;
        else j = 0;
        i++;
    }
    return found;
}

void printString(char str[], int length) {
    for (int i = 0; i < length; i++) {
        cout << str[i];
    }
}

int main() {
    const int length = 10;
    char str[length];
    cin.getline(str, length);

    char substr[length];
    cin.getline(substr, length);

    cout << endl << findSubString(str, substr, length);

    return 0;
}