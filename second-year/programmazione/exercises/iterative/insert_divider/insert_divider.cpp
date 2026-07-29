#include <iostream>
using namespace std;

int main() {
    int n;
    cout << "Insert a number: ";
    cin >> n;
    
    int x;
    cout << "Insert a divider: ";
    cin >> x;

    while (n % x != 0) {
        cout << x << " is not a divider of " << n << endl;
        cout << "Insert another divider: ";
        cin >> x;
    }
    cout << "Great! " << x << " is a divider of " << n;

    return 0;
}