#include <iostream>
using namespace std;

int main() {
    double tot;
    cout << "Insersci il totale in euro: ";
    cin >> tot;

    int n2eur, n1eur, n50cent, n20cent, n10cent, n5cent, n2cent, n1cent;

    int totCents = tot * 100;

    n2eur = totCents / 200;
    totCents %= 200;
    n1eur = totCents / 100;
    totCents %= 100;
    n50cent = totCents / 50;
    totCents %= 50;
    n20cent = totCents / 20;
    totCents %= 20;
    n10cent = totCents / 10;
    totCents %= 10;
    n5cent = totCents / 5;
    totCents %= 5;
    n2cent = totCents / 2;
    totCents %= 2;
    n1cent = totCents / 1;
    totCents %= 1;

    cout << "You need: "
        << n2eur << " 2 euro coins, "
        << n1eur << " 1 euro coins, "
        << n50cent << " 50 cent coins, "
        << n20cent << " 20 cent coins, "
        << n10cent << " 10 cent coins, "
        << n5cent << " 5 cent coins, "
        << n2cent << " 2 cent coins, and "
        << n1cent << " 1 cent coins";
}