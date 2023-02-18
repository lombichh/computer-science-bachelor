#include <iostream>
using namespace std;

int main() {
    int x0, y0, x1, y1;
    cin >> x0 >> y0 >> x1 >> y1;

    if (x0 == x1 && y0 == y1) cout << "I punti sono sovrapposti";
    else if (x0 != x1) {
        int m = (y1 - y0) / (x1 - x0);
        int q = y0 - m * x0;
        cout << "y = " << m << "x + " << q;
    } else cout << "x = " << x0;
}