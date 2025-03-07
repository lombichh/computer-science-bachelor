#include <iostream>
using namespace std;

int main() {
	// exchange two characters section
	cout << "- Exchange two characters -" << endl;

	char a, b;

	// identifiers input
	cout << "a: ";
	cin >> a;
	cout << "b: ";
	cin >> b;

	cout << "Before swap a=" << a << " b=" << b << endl;

	char c = a;

	a = b;
	b = c;

	cout << "After swap a=" << a << " b=" << b << endl;

	// exchange two numbers section
	cout << "- Exchange two numbers -" << endl;

	int x, y;

	// identifiers input
	cout << "x: ";
	cin >> x;
	cout << "y: ";
	cin >> y;

	cout << "Before swap x=" << x << " y=" << y << endl;

	x = x * y;
	y = x / y;
	x /= y;

	cout << "After swap x=" << x << " y=" << y << endl;
}
