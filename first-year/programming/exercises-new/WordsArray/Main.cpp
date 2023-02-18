#include <iostream>
using namespace std;

int parola(char str[], int length, int n) {
    int i = 0;
    int wordsCount = 0;
    int destStart = -1;
    int destEnd = -1;

    while (wordsCount < n && i < length) {
        if ((str[i - 1] == ' ' && str[i] != ' ') || (i == 0 && str[i] != ' ')) {
            destStart = i;
            wordsCount++;
        } else if ((str[i] == ' ' && str[i - 1] != ' ') || (i == length - 1 && str[i] != ' ')) destEnd = i;
        i++;
    }

    int destLength = destEnd - destStart;
    char dest[destLength];
    if (destStart != -1) {
        for (int j = destStart; j < destEnd; j++) {
            dest[j - destStart] = str[j];
        }
    }

    for (int m = 0; m < destLength; m++) {
        cout << dest[m] << ", ";
    }

    return destLength;
}

int main() {
    const int length = 20;
    char strArray[length];

    // create strarray
    for (int i = 0; i < 5; i++) {
        strArray[i] = 'a';
    }
    for (int i = 4; i < 8; i++) {
        strArray[i] = ' ';
    }
    for (int i = 7; i < 13; i++) {
        strArray[i] = 'a';
    }
    for (int i = 12; i < 14; i++) {
        strArray[i] = ' ';
    }
    for (int i = 13; i < length; i++) {
        strArray[i] = 'a';
    }

    for (int m = 0; m < length; m++) {
        cout << strArray[m] << ", ";
    }
    cout << endl;

    parola(strArray, length, 1);

    return 0;
}