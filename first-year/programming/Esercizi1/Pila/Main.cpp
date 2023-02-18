#include <iostream>
using namespace std;

bool isEmpty(int& i) {
    if (i == 0) return true;
    else return false;
}

void push(int pila[], int length, int& i, int item) {
    if (i < length) {
        pila[i] = item;
        i++;
    } else cout << "overflow" << endl;
}

int pop(int pila[], int& i) {
    if (i > 0) {
        i--;
        return pila[i];
    } else cout << "underflow" << endl;
}

int main() {
    const int length = 10;
    int pila[length];
    int i = 0;

    cout << isEmpty(i) << endl;
    push(pila, length, i, 0);
    push(pila, length, i, 1);
    push(pila, length, i, 2);
    push(pila, length, i, 3);
    push(pila, length, i, 4);
    push(pila, length, i, 5);
    push(pila, length, i, 6);
    push(pila, length, i, 7);
    push(pila, length, i, 8);
    push(pila, length, i, 9);
    push(pila, length, i, 10);
    cout << isEmpty(i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << "pop: " << pop(pila, i) << endl;
    cout << isEmpty(i) << endl;

    return 0;
}
