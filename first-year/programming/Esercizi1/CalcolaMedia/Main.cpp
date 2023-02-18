#include <iostream>
using namespace std;

int main() {
    int x;

    int counter = 0;
    double sum = 0;
    do {
        cin >> x;
        if (x != 0) {
            sum += x;
            counter++;
            cout << "average: " << sum / counter << endl;
        }
    } while (x != 0);

    return 0;
}