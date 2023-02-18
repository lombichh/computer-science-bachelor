#include <cmath>
#include <iostream>
using namespace std;

int main() {
	cout << "Insert the height: ";
	int n;
	cin >> n;

	int base = n * 2 - 1;

	for (int i = 1; i <= base; i += 2) {
		for (int j = 0; j < ((base + i) / 2); j++) {
			if (j < ((base - i) / 2)) cout << " ";
			else cout << "*";
		}
		cout << endl;
	}

	return 0;
}
