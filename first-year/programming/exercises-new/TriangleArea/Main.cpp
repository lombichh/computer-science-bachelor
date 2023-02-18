#include <iostream>
using namespace std;

int main() {
	double base, height;

	cout << "Insert the base: ";
	cin >> base;
	cout << "Insert the height: ";
	cin >> height;

	double area = (base * height) / 3;
	cout << "The area is: " << area;
}
