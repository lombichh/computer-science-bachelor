#include <iostream>
using namespace std;

bool isPalindrome(int array[], int length) {
	int i = 0;
	bool pal = true;

	while (i < length / 2 && pal) {
		if (array[i] != array[length - i - 1]) pal = false;
		else i++;
	}

	return pal;
}

int main() {
	int l;
	cout << "Insert the length: ";
	cin >> l;

	int a[l];
	for (int i = 0; i < l; i++) {
		int x;
		cout << "Insert a number: ";
		cin >> x;
		a[i] = x;
	}

	if (isPalindrome(a, l)) cout << "The array is palindrome";
	else cout << "The array is not palindrome";

	return 0;
}
