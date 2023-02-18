#include <iostream>
using namespace std;

int main() {
	// given 3 integers prints the number closer to the average
	cout << "Insert 3 integers: ";
	int n1, n2, n3, n4;
	cin >> n1 >> n2 >> n3 >> n4;

	int average = (n1 + n2 + n3 + n4) / 3;

	int closerInt = n1;
	int closerDiff = abs(n1 - average);

	if (abs(n2 - average) < closerDiff) {
		closerInt = n2;
		closerDiff = n2 - average;
	}
	if (abs(n3 - average) < closerDiff) {
		closerInt = n3;
		closerDiff = n3 - average;
	}
	if (abs(n4 - average) < closerDiff) closerInt = n4;

	cout << "The number closer to the average is: " << closerInt;
}
