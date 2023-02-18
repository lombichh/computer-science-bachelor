#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

void createRandomArray(int arr[], int length) {
	srand(time(0));
    for (int i = 0; i < length; i++) {
		arr[i] = rand() % 10;
	}
}

void printArray(int arr[], int length) {
    for (int i = 0; i < length; i++) {
        cout << arr[i] << " ";
    }
    cout << endl;
}

void copyArray(int firstArray[], int secondArray[], int length) {
    for (int i = 0; i < length; i++) {
        secondArray[i] = firstArray[i];
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

int main() {
    int length;
    cout << "Length: ";
	cin >> length;

    // create first array
	int array[length];
    createRandomArray(array, length);

    printArray(array, length);

    // create second array
    int orderedArray[length];
    copyArray(array, orderedArray, length);
    // order second array
    quickSort(orderedArray, 0, length - 1);

    printArray(orderedArray, length);

    // create difference array
    int differenceArray[length];
    for (int i = 0; i < length; i++) {
        differenceArray[i] = array[i] - orderedArray[i];
    }
    printArray(differenceArray, length);

	return 0;
}
