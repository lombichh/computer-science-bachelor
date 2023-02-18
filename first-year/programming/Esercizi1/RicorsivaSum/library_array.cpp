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