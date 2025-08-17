#include <iostream>
#include "library_array.h"
using namespace std;

bool isTwoOccurrences(int arr[], int length, int index) {
    bool already_checked = false;
    int numOcc = 0;
    int i = 0;

    while (i < length && numOcc < 2 && !already_checked) {
        if (arr[i] == arr[index]) {
            if (i < index) already_checked = true;
            else numOcc++;
        }
        i++;
    }

    return numOcc == 2;
}

int twoOccurrences(int arr[], int length) {
    int twoOcc = 0;

    for (int i = 0; i < length; i++) {
        if (isTwoOccurrences(arr, length, i)) twoOcc++;
    }

    return twoOcc;
}

int main() {
    const int length = 10;
    int arr[length];
    randomArray(arr, length, 10);

    printArray(arr, length, 0);

    cout << twoOccurrences(arr, length);

    return 0;
}