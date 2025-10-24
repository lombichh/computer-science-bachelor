#include "library_array.h"
#include <iostream>
using namespace std;

int numDuplicated(int arr[], int length, int item) {
    int numDuplicated = 0;

    for (int i = 0; i < length; i++) {
        if (arr[i] == item) numDuplicated++; 
    }

    return numDuplicated;
}

int maxDuplicated(int arr[], int length) {
    int maxDuplicated = 0;

    for (int i = 0; i < length; i++) {
        int currentDuplicated = numDuplicated(arr, length, arr[i]);
        if (currentDuplicated > maxDuplicated) maxDuplicated = currentDuplicated;
    }

    return maxDuplicated;
}

int main() {
    const int length = 10;
    int arr[length];
    randomArray(arr, length, 10);
    printArray(arr, length, false);

    cout << "Max duplicated: " << maxDuplicated(arr, length);

    return 0;
}