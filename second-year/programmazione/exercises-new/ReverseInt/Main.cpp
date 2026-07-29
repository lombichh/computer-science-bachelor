#include <cmath>
#include <iostream>
using namespace std;

int reverseInt(int num) {
	int reversedNum = 0;

	while (num > 0) {
		reversedNum *= 10;
		reversedNum += num % 10;

		num /= 10;
	}

	return reversedNum;
}

int main() {
	int n;
	cin >> n;

	cout << reverseInt(n);

	return 0;
}
