#include <iostream>
using namespace std;

int give_occ(int arr[], int i, int n) {
    if (i < 0) return 0;
    else {
        if (n == arr[i]) return give_occ(arr, i - 1, n) + 1;
        else return give_occ(arr, i - 1, n);
    }
}

int give_max_occ(int arr[], int length, int& max) {
    if (length == 0) return 0;
    else {
        int curr = arr[length - 1];
        int currocc = give_occ(arr, length, curr);
        
        int sub;
        int subocc = give_max_occ(arr, length - 1, sub);

        if (currocc > subocc) {
            max = curr;
            return currocc;
        } else return subocc;
    }
}

int main() {
    int length = 10;
    int arr[length] = {1, 4, 2, 5, 3, 3, 2, 2, 5};

    int max;
    cout << give_max_occ(arr, length - 1, max);
    cout << max;

    return 0;
}