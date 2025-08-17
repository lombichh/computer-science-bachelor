#include "library_array.h"
#include <iostream>
#include <math.h>
using namespace std;

int maxDifference(int arr[], int length) {
    int maxDifference = 0;

    for (int i = 0; i < length; i++) {
        for (int j = i + 1; j < length; j++) {
            int currentDifference = abs(arr[j] - arr[i]);
            if (currentDifference > maxDifference)
                maxDifference = currentDifference;
        }
    }

    return maxDifference;
}

int main() {
    const int length = 10;
    int arr[length];
    randomArray(arr, length, 10);
    printArray(arr, length, false);

    cout << "Max difference: " << maxDifference(arr, length);

    return 0;
}