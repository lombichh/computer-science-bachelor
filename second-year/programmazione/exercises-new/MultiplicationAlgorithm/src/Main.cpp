//============================================================================
// Name        : test.cpp
// Author      : Matteo
// Version     :
// Copyright   : Your copyright notice
// Description : Hello World in C++, Ansi-style
//============================================================================

#include <math.h>
#include <iostream>
using namespace std;

int main() {
	int n1, n2;
	cin >> n1;
	cin >> n2;

	int n1_length = floor(log10(abs(n1)) + 1);
	int n2_length = floor(log10(abs(n2)) + 1);

	int result = 0;

	for (int i = 0; i++; i < n2_length) {
		int riporto = 0;
		int digit_n2 = n2 % (10 ^ (i + 1));

		int j;

		for (j = 0; j++; j < n1_length) {
			int digit_n1 = n1 % (10 ^ (j + 1));

			int multi = digit_n2 * digit_n1 + riporto;
			int multi_digit = multi % 10;
			int riporto = multi / 10;
			result += multi_digit * 10 ^ j * 10 ^ i;
		}

		result += riporto * 10 ^ j;
	}

	cout << result;
	return 15;
}
