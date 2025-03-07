#include "library_array.h"
#include <iostream>
using namespace std;

int binarySearch(int arr[], int value, int min, int max) {
    int mid = (max - min) / 2;
    
    if (value == mid) return value;
    else if (value < mid) binarySearch(arr, value, min, mid - 1);
    else binarySearch(arr, value, mid + 1, max);
}

int main() {
    const int length = 10;
    int arr[length];
    randomArray(arr, length, 10);

    printArray(arr, length, false);
    cout << binarySearch(arr, 5, 0, 9);

    return 0;
}