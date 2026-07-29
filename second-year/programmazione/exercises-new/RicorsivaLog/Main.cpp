#include <math.h>
#include <iostream>
using namespace std;

int log(int n, int i) {
    if (pow(2, i) <= n) log(n, i + 1);
    else return(i - 1);
}

int main() {
    cout << log(15, 0);

    return 0;
}