#include "library_array.h"
#include <cstdlib>
#include <ctime>
#include <iostream>
using namespace std;

void initializeArray(int array[], const int length) {
    for (int i = 0; i < length; i++) {
        array[i] = 0;
    }
}

void randomArray(int array[], const int length, int max) {
    srand(time(0));

    for (int i = 0; i < length; i++) {
        array[i] = rand() % max;
    }
}

void printArray(const int array[], const int length, bool reverse) {
    if (reverse) {
        for (int i = length - 1; i >= 0; i--) {
            cout << array[i] << ", ";
        }
    } else {
        for (int i = 0; i < length; i++) {
            cout << array[i] << ", ";
        }
    }
    cout << endl;
}

void concatenateArray(int array1[], int array2[], const int length1, const int length2, int array3[]) {
    for (int i = 0; i < length1 + length2; i++) {
        if (i < length1) array3[i] = array1[i];
        else array3[i] = array2[i - length1];
    }
}

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