#include <cmath>
#include <iostream>
using namespace std;

int bin2Dec(int bin) {
	int dec = 0;

	int exp = 1;
	while (bin > 0) {
		if (bin % 10 == 1) dec += exp;

		bin /= 10;
		exp *= 2;
	}

	return dec;
}

int dec2Bin(int dec) {
	int bin = 0;

	int exp = 1;
	while (dec > 0) {
		bin += (dec % 2) * exp;

		dec /= 2;
		exp *= 10;
	}


	return bin;
}

int main() {
	int bin1;
	int bin2;
	cin >> bin1 >> bin2;

	int int1 = bin2Dec(bin1);
	int int2 = bin2Dec(bin2);

	int intSum = int1 + int2;

	cout << dec2Bin(intSum);

	return 0;
}
