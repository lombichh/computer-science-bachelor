#include "library_array.h"
#include <iostream>
using namespace std;

int search(char A[], int l) {
    int i = l - 2;

    while (i > -1 && A[i] != A[i + 1]) i--;

    return i;
}

int main() {
    const int length = 7;
    char arr[length] = {'a', 'b', 'c', 'd', 'e', 'g', 'f'};

    cout << search(arr, length);

    return 0;
}