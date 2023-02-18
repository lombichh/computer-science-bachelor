#include <iostream>
#include <cstring>
using namespace std;

bool ghChInString(char str[], int length) {
    if (length < 2) return false;
    else if (str[length - 1] == 'h' && (str[length - 2] == 'g' || str[length - 2] == 'c'))
        return true;
    else ghChInString(str, length - 1);
}

int main() {
    char str1[] = "jnjnknjbg";
    cout << ghChInString(str1, strlen(str1));

    return 0;
}