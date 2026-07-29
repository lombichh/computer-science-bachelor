#include <iostream>
using namespace std;

int main() {
	// given 3 integers prints if one of them is a divider for the others
	int x, y, z;
	cin >> x >> y >> z;

	cout << (((y % x) == 0) && ((z % x) == 0))
		|| (((x % y) == 0) && ((z % y) == 0))
		|| (((x % z) == 0) && ((y % z) == 0));

	return 0;
}
