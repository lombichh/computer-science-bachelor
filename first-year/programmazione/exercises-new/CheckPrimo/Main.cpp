#include <cmath>
#include <iostream>
using namespace std;

int main() {
	int n;
	cout << "Insert a number: ";
	cin >> n;

	if (n == 2) cout << true;
	else {
		int i = 2;

		while (i <= sqrt(n) && (n % i) != 0) i++;
		cout << (n % i != 0);
	}

	return 0;
}
