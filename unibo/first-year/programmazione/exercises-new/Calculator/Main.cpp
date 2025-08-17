#include <iostream>
using namespace std;

int main() {
	bool continueLoop = true;

	while (continueLoop) {
		cout << "--- Calculator ---" << endl
						<< "0 - Exit" << endl
						<< "1 - Addition" << endl
						<< "2 - Subtraction" << endl
						<< "3 - Multiplication" << endl
						<< "4 - Division" << endl;

		int operation;
		cin >> operation;

		if (operation == 0) continueLoop = false;
		else {
			cout << "Insert two integers: " << endl;

			int x, y;
			cin >> x >> y;

			int result;

			if (operation == 1) result = x + y;
			else if (operation == 2) result = x - y;
			else if (operation == 3) result = x * y;
			else if (operation == 4) result = x / y;

			cout << "The result is: " << result << endl;
		}
	}

	return 0;
}
