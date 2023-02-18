#include <iostream>
using namespace std;

int main() {
	double tot;
	cout << "Totale: ";
	cin >> tot;

	double remained = tot;

	int n2eur = (int)(tot/2);
	remained -= 2*n2eur;
	int n1eur = remained/1;
	remained -= n1eur;
	int n50cent = remained/0.5;
	remained -= 0.5 * n50cent;
	int n20cent = remained/0.2;
	remained -= 0.2 * n20cent;
	int n2cent = remained/0.02;

	cout << "2 euro: " << n2eur << endl
			<< "1 euro: " << n1eur << endl
			<< "50 cent: " << n50cent << endl
			<< "20 cent: " << n20cent << endl
			<< "2 cent: " << n2cent;

	return 0;
}
