#include "library_array.h"
#include <iostream>
using namespace std;

int sum(int arr[], int length) {
    if (length == 0) return 0;
    else return (arr[length - 1] + sum(arr, length - 1));
}

int main() {
    const int length = 10;
    int arr[length];
    randomArray(arr, length, 10);
    printArray(arr, length, false);

    cout << sum(arr, length);

    return 0;
}