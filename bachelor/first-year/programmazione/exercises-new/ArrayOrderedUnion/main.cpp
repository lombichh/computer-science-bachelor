#include "library_array.h"
#include <iostream>
using namespace std;

int createIsDupArray(int array[], int isDupArray[], int length) {
    isDupArray[0] = 1;

    int noDupArrayLength = 1;
    for (int i = 1; i < length; i++) {
        if (array[i] == array[i - 1]) isDupArray[i] = 0;
        else {
            isDupArray[i] = 1;
            noDupArrayLength++;
        }
    }

    return noDupArrayLength;
}

void createNoDupArray(int array[], int isDupArray[], int noDupArray[], int length, int noDupArrayLength) {
    int j = 0;

    for (int i = 0; i < length; i++) {
        if (isDupArray[i]) {
            noDupArray[j] = array[i];
            j++;
        }
    }
}

int main() {
    const int length1 = 10;
    int array1[length1];
    randomArray(array1, length1, 10);
    cout << "Array 1: ";
    printArray(array1, length1, false);
    
    const int length2 = 10;
    int array2[length2];
    randomArray(array2, length2, 15);
    cout << "Array 2: ";
    printArray(array2, length2, false);
    
    const int orderedUnionArrayLength = length1 + length2;
    int orderedUnionArray[orderedUnionArrayLength];
    concatenateArray(array1, array2, length1, length2, orderedUnionArray);
    
    quickSort(orderedUnionArray, 0, orderedUnionArrayLength);
    int isDupArray[orderedUnionArrayLength];
    int noDupArrayLength = createIsDupArray(orderedUnionArray, isDupArray, orderedUnionArrayLength);
    int orderedUnionNoDupArray[noDupArrayLength];
    createNoDupArray(orderedUnionArray, isDupArray, orderedUnionNoDupArray, orderedUnionArrayLength, noDupArrayLength);

    cout << "Ordered union array: ";
    printArray(orderedUnionNoDupArray, noDupArrayLength, false);

    return 0;
}