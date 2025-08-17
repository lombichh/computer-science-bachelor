#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

int main() {
    srand(time(0));
    int number = rand() % 100;

    int x;
    cin >> x;
    while (x != number) {
        if (x > number) cout << "Too big" << endl;
        else if (x < number) cout << "Too small" << endl;
        cin >> x;
    };

    cout << "Number found!!";

    return 0;
}