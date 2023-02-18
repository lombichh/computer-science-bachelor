#include <cmath>
#include <iostream>
using namespace std;

int main() {
	cout << "Insert the number of rows: ";
	int m;
	cin >> m;
	cout << "Insert the number of columns: ";
	int n;
	cin >> n;

	for (int i = 0; i < m; i++) {
		for (int j = 0; j < n; j++) cout << "*";
		cout << endl;
	}

	return 0;
}
