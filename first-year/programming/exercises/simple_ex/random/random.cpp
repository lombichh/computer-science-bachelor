#include <iostream>
#include <cstdlib>
#include <ctime>
using namespace std;

int main() {
    srand(time(0));
    cout << "Random number (0-89): " << rand() % 90;
}