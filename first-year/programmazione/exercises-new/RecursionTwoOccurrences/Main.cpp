#include <iostream>
#include <cstring>
using namespace std;

bool is_two_occurrences(char arr[], int length, int i, int occ) {
    if (length == 0) return occ == 2;
    else {
        if (arr[length - 1] == arr[i]) {
            
        }
        is_two_occurrences(arr, length - 1, c, occ);
    }
}

int two_occurrences(char arr[], int length) {
    if (length == 0) return 0;
    else {
        if (is_two_occurrences) ;
        int occ = give_occ(arr, length - 1, arr[length - 1]);
        if (occ == 2) return two_occurrences(arr, length - 1) + 1;
        else return two_occurrences(arr, length - 1);
    }
}

int main() {
    char str[] = "abbracciare";

    cout << two_occurrences(str, strlen(str));
    
    return 0;
}