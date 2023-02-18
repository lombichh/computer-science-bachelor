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

bool isDup(int arr[], int length, int itemIndex) {
    for (int i = 0; i < length; i++) {
        if (arr[i] == arr[itemIndex] && i != itemIndex) {
            return true;
        }
    }
    return false;
}

int createIsDupArray(int arr[], int isDupArr[], int length) {
    int noDupLength = 0;

    for (int i = 0; i < length; i++) {
        if (isDup(arr, length, i)) isDupArr[i] = 0;
        else {
            isDupArr[i] = 1;
            noDupLength++;
        }
    }

    return noDupLength;
}

void createArrayWithoutDup(int arr[], int length) {
    int isDupArr[length];
    int noDupLength = createIsDupArray(arr, isDupArr, length);

    int noDupArr[noDupLength];

    int j = 0;
    for (int i = 0; i < length; i++) {
        if (isDupArr[i]) {
            noDupArr[j] = arr[i];
            j++;
        }
    }

    printArray(noDupArr, noDupLength);
}

int main() {
    const int length = 5;

	int array[length];
    createRandomArray(array, length);
    printArray(array, length);
    
    int isDupArr[length];
    int noDupLength = createIsDupArray(array, isDupArr, length);

    int noDupArr[noDupLength];
    createArrayWithoutDup(array, isDupArr, noDupArr, noDupLength, length);

	return 0;
}