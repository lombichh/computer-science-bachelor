#include <cmath>
#include <iostream>
using namespace std;

int main() {
	double n;
	cout << "Insert a number: " << endl;
	cin >> n;

	int decimalDigits;
	cout << "Insert the number of decimal digits: " << endl;
	cin >> decimalDigits;
	decimalDigits = -decimalDigits;

	double rad;

	int i = 0;
	while (i >= decimalDigits) {
		while ((rad + pow(10, i)) * (rad + pow(10, i)) <= n) rad += pow(10, i);
		i--;
	}

	cout << rad;

	return 0;
}
