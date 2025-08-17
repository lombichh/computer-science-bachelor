#include <cmath>
#include <iostream>
using namespace std;

int bin2Dec(int binary) {
	int exp = 1;
	int decimal = 0;
	while (binary > 0) {
		if (binary % 10 == 1) decimal += exp;

		binary /= 10;
		exp *= 2;
	}

	return decimal;
}

int main() {
	int binary;
	cin >> binary;

	cout << bin2Dec(binary);

	return 0;
}
