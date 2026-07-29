#include <cmath>
#include <iostream>
using namespace std;

int main() {
	cout << "Insert the base: ";
	int b;
	cin >> b;

	for (int i = 1; i <= b; i++) {
		for (int j = 1; j <= i; j++) cout << "*";
		cout << endl;
	}

	return 0;
}
