#include <iostream>
using namespace std;
#include <math.h>

int main() {
	float radius;

	cout << "Insert the radius: ";
	cin >> radius;

	cout << "The area is: " << (M_PI * pow(radius, 2));
}
