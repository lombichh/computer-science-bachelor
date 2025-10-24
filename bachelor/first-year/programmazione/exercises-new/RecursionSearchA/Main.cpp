#include <iostream>
using namespace std;

int search_a(char a[], int i) {
    if (a[i] == '\0') return 0;
    else {
        int a_substring = search_a(a, i + 1);
        if (a[i] == 'a') return (1 + a_substring);
        else return a_substring;
    }
}

int main() {
    char str[] = "asgfassfd";
    cout << search_a(str, 0);

    return 0;
}