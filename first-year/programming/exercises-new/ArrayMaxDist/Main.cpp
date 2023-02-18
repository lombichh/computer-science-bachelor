#include "library_array.h"
#include <iostream>
using namespace std;

int nextIndex(int arr[], int length, int start) {
    int item = arr[start];

    int i = start;
    bool found = false;
    while (i < (length - 1) && !found) {
        i++;
        if (arr[i] == item) found = true;
    }

    if (found) return i;
    else return -1;
}

int maxDist(int arr[], int length) {
    int dist = -1;

    for (int i = 0; i < length; i++) {
        int nxIndex = nextIndex(arr, length, i);
        if (nxIndex != -1) {
            int newDist = nxIndex - i;
            if (newDist > dist) dist = newDist;
        }
    }

    return dist;
}

int main() {
    const int length = 10;
    int arr[length];
    randomArray(arr, length, 10);
    printArray(arr, length, false);

    cout << "Max dist: " << maxDist(arr, length);

    return 0;
}