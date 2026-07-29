#include <iostream>
using namespace std;

int main() {
	int n;
	cout << "Insert a number: ";
	cin >> n;

	int rad = 0;

	while ((rad + 1) * (rad + 1) <= n) rad++;
	cout << rad;

	return 0;
}
