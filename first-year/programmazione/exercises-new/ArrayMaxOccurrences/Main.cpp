#include <iostream>
#include "library_array.h"
using namespace std;

int numOccurrences(int arr[], int length, int item) {
    int numOcc = 0;

    for (int i = 0; i < length; i++) {
        if (arr[i] == item) numOcc++;
    }

    return numOcc;
}

int maxOccurrences(int arr[], int length) {
    int maxOcc = 0;

    for (int i = 0; i < length; i++) {
        int numOcc = numOccurrences(arr, length, arr[i]);
        if (numOcc > maxOcc) maxOcc = numOcc;
    }

    return maxOcc;
}

int main() {
    const int length = 10;
    int arr[length];
    randomArray(arr, length, 10);

    printArray(arr, length, 0);

    cout << maxOccurrences(arr, length);

    return 0;
}