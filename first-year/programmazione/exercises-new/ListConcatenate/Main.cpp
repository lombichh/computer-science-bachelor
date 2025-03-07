#include <iostream>
using namespace std;

struct lista {
    int val;
    lista *next;
};
typedef lista* p_lista;

void printLista(p_lista head) {
    p_lista tmp = head;

    while (tmp != NULL) {
        cout << tmp -> val << " -> ";
        tmp = tmp -> next;
    }
    cout << endl;
}

p_lista concat(p_lista head1, p_lista head2) {
    p_lista tmp = head1;
    while (tmp -> next != NULL) tmp = tmp -> next;
    tmp -> next = head2;

    return head1;
}

p_lista removeDup(p_lista head) {
    p_lista tmpBefore = head;

    if (tmpBefore -> next == NULL) return head;
    else {
        p_lista tmp = tmpBefore -> next;

        if (tmpBefore -> val == tmp -> val) {
            tmpBefore -> next = tmp -> next;
            tmp = tmp -> next;
        }

        while (tmp -> next != NULL) {
            p_lista tmp1 = tmp -> next;
            bool dup = false;
            while (tmp1 -> next != NULL && !dup) {
                if (tmp -> val == tmp1 -> val) {
                    dup = true;
                    tmpBefore -> next = tmp -> next;
                    tmp = tmp -> next;
                }
                tmp1 = tmp1 -> next;
            }
            tmpBefore = tmpBefore -> next;
            tmp = tmp -> next;
        }

        return head;
    }
}

int main() {
    // lista 1
    p_lista p1, p2, p3;

    p1 = new lista;
    p2 = new lista;
    p3 = new lista;

    p1 -> next = p2;
    p2 -> next = p3;
    p3 -> next = NULL;

    p1 -> val = 1;
    p2 -> val = 2;
    p3 -> val = 3;
    
    // lista 2
    p_lista g1, g2, g3;

    g1 = new lista;
    g2 = new lista;
    g3 = new lista;

    g1 -> next = g2;
    g2 -> next = g3;
    g3 -> next = NULL;

    g1 -> val = 2;
    g2 -> val = 2;
    g3 -> val = 2;

    printLista(p1);
    printLista(g1);

    p_lista h1 = concat(p1, g1);
    printLista(h1);

    p_lista j1 = removeDup(h1);
    printLista(j1);
}