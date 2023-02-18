#include <cmath>
#include <iostream>
using namespace std;

int main() {
	cout << "Insert the radius: ";
	int r;
	cin >> r;

	for (int stars = 2; stars <= (r * 2); stars += 2) {
		for (int j = 0; j < (stars + 2 * r) / 2; j++) {
			if (j < (r - stars / 2)) cout << " ";
			else cout << "*";
		}
		cout << endl;
	}
	for (int stars = (r * 2); stars > 0; stars -= 2) {
		for (int j = 0; j < (stars + 2 * r) / 2; j++) {
			if (j < (r - stars / 2)) cout << " ";
			else cout << "*";
		}
		cout << endl;
	}

	return 0;
}
