#include <iostream>
using namespace std;

struct lista {
    int val;
    lista* next;
};
typedef lista* p_lista;

p_lista head_insert(p_lista h, int e) {
    p_lista tmp = new lista;
    tmp -> val = e;
    tmp -> next = h;
    return tmp;
}

int main() {
    int n;
    cout << "List length: " << endl;
    cin >> n;

    p_lista h = NULL;
    for (int i = 0; i < n; i++) {
        h = head_insert(h, i*i);
    }

    p_lista tmp = h;
    while (tmp != NULL) {
        cout << tmp -> val << " ";
        tmp = tmp -> next;
    }
}