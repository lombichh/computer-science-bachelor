#include <iostream>
#include <cstdlib>
#include <ctime>
#include "library_array.h"
using namespace std;

void printArray(int arr[], int length) {
    for (int i = 0; i < length; i++) {
        cout << arr[i] << ", ";
    }
    cout << endl;
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

double getMediano(int arr[], int length) {
    if (length % 2 != 0) return arr[length / 2];
    else return (arr[(length / 2) - 1] + arr[length / 2]) / 2.0;
}

int main() {
    const int length = 6;

    // create first array
	int array[length];
    initializeArray(array, length);
    randomArray(array, length, 5);
    // order array
    quickSort(array, 0, length - 1);
    printArray(array, length);
    
    cout << "Mediano: " << getMediano(array, length);

	return 0;
}