#include <iostream>
using namespace std;

int main()
{
	int x, y, z;
	cout << "Insert 3 integers: ";
	cin >> x >> y >> z;

	if (y < x) {
		int temp = y;
		y = x;
		x = temp;
	}

	if (z < x) {
		int temp = z;
		z = y;
		y = x;
		x = temp;
	} else if (z < y) {
		int temp = z;
		z = y;
		y = temp;
	}

	cout << x << " " << y << " " << z;
}
