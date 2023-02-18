#include <iostream>
#include <cstring>
using namespace std;

void printLonger(char a[], char b[]) {
    int lena = strlen(a);
    int lenb = strlen(b);
    if (lena > lenb) cout << a;
    else if (lenb > lena) cout << b;
    else cout << "Le stringhe sono uguali";
}

int main() {
    char str1[10] = "kdsnjnkjn";
    char str2[10] = "sdnjksn";

    printLonger(str1, str2);

    return 0;
}