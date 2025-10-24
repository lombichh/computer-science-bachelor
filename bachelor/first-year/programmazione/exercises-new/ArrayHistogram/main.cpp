#include "library_array.h"
#include <iostream>
using namespace std;

void printHistogram(int array[], const int length) {
    for (int i = 0; i < length; i++) {
        cout << i << "(" << array[i] << "): ";
        for (int j = 0; j < array[i]; j++) cout << "X";
        cout << endl;
    }
}

int getFrequence(int array[], int length, int item) {
    int occ = 0;

    for (int i = 0; i < length; i++) {
        if (array[i] == item) occ++;
    }

    return occ;
}

int getTrend(int array[], int length) {
    int trend = array[0];
    int trendFrequence = getFrequence(array, length, array[0]);

    for (int i = 1; i < length; i++) {
        int currentItemFrequence = getFrequence(array, length, array[i]);
        if (currentItemFrequence > trendFrequence) {
            trend = array[i];
            trendFrequence = currentItemFrequence;
        }
    }

    return trend;
}

void frequenceSort(int array[], int length) {
    for (int i = 0; i < length; i++) {
        int iFrequence = getFrequence(array, length, array[i]);
        for (int j = i + 1; j < length; j++) {
            int jFrequence = getFrequence(array, length, array[j]);
            if (jFrequence > iFrequence || ((i - 1 > 0) && array[i - 1] == array[j])) {
                int tmp = array[i];
                array[i] = array[j];
                array[j] = tmp;
                iFrequence = jFrequence;
            }
        }
    }
}

int main() {
    const int length = 10;
    int array[length];
    initializeArray(array, length);

    int max;
    cout << "Max number in the array: ";
    cin >> max;

    randomArray(array, length, max);
    printHistogram(array, length);

    cout << endl;
    cout << "Trend: " << getTrend(array, length) << endl;
    cout << endl;

    frequenceSort(array, length);
    printHistogram(array, length);

    return 0;
}