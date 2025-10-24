#include <iostream>
using namespace std;

void evenOddArray2(int arr[], int i, int l) {
    if (l > i) {
        if (arr[i] % 2 != 0) {
            int tmp = arr[i];
            arr[i] = arr[l];
            arr[l] = tmp;
            evenOddArray2(arr, i, l - 1);
        } else evenOddArray2(arr, i + 1, l);
    }
}

void evenOddArray(int arr1[], int even[], int evenN, int odd[], int oddN, int arr2[], int length) {
    if (length == 0) {
        // concatenate even[] odd[]
        for (int i = 0; i < evenN; i++) arr2[i] = even[i];
        for (int i = 0; i < oddN; i++) arr2[evenN + i] = odd[i];
        return;
    } else {
        if (arr1[length - 1] % 2 == 0) {
            even[evenN] = arr1[length - 1];
            evenN++;
        } else {
            odd[oddN] = arr1[length - 1];
            oddN++;
        }
        evenOddArray(arr1, even, evenN, odd, oddN, arr2, length - 1);
    }
}

int main() {
    int length = 8;
    int arr[length] = {1, 2, 3, 4, 5, 6, 7, 8};
    int arr2[length];
    evenOddArray2(arr, 0, length - 1);

    for (int i = 0; i < length; i++) {
        cout << arr[i] << ", ";
    }

    return 0;
}