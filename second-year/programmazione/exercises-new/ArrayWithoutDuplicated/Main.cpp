#include "library_array.h"
#include <iostream>
using namespace std;

int partition(int arr[], int start, int end) {
    int pivot = arr[start];
 
    int count = 0;
    for (int i = start + 1; i <= end; i++) {
        if (arr[i] <= pivot)
            count++;
    }
 
    // Giving pivot element its correct position
    int pivotIndex = start + count;
    swap(arr[pivotIndex], arr[start]);
 
    // Sorting left and right parts of the pivot element
    int i = start, j = end;
 
    while (i < pivotIndex && j > pivotIndex) {
 
        while (arr[i] <= pivot) {
            i++;
        }
 
        while (arr[j] > pivot) {
            j--;
        }
 
        if (i < pivotIndex && j > pivotIndex) {
            swap(arr[i++], arr[j--]);
        }
    }
 
    return pivotIndex;
}
 
void quickSort(int arr[], int start, int end) {
    // base case
    if (start >= end)
        return;
 
    // partitioning the array
    int p = partition(arr, start, end);
 
    // Sorting the left part
    quickSort(arr, start, p - 1);
 
    // Sorting the right part
    quickSort(arr, p + 1, end);
}

void removeDupArray(int array[], int length) {
    int isDupArray[length];
    isDupArray[0] = 1;

    int noDupArrayLength = 1;
    for (int i = 1; i < length; i++) {
        if (array[i] == array[i - 1]) isDupArray[i] = 0;
        else {
            isDupArray[i] = 1;
            noDupArrayLength++;
        }
    }

    int noDupArray[noDupArrayLength];
    int j = 0;
    for (int i = 0; i < length; i++) {
        if (isDupArray[i]) {
            noDupArray[j] = array[i];
            j++;
        }
    }

    printArray(noDupArray, noDupArrayLength, false);
}

int main() {
    const int length = 10;
    int array[length];

    randomArray(array, length, 10);
    printArray(array, length, false);
    quickSort(array, 0, 10);

    removeDupArray(array, length);

	return 0;
}