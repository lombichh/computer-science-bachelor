#include <iostream>
using namespace std;

int main() {
	int x, y, z;
	cout << "First number: ";
	cin >> x;
	cout << "Second number: ";
	cin >> y;
	cout << "Third number: ";
	cin >> z;
	double average = (x+y+z)/3.0;
	cout << "The average is: " << average;
	return 0;
}
