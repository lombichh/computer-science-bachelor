#include <iostream>
#include <cstring>
using namespace std;

struct node {
    double val;
    int left;
    int right;
};

int max(int n1, int n2) {
    if (n1 > n2) return n1;
    else return n2;
}

int altezza(node albero[], int index = 0) {
    if (albero[index].left == -1 && albero[index].right == -1) {
        return 0;
    } else {
        int left_length = 0;
        int right_length = 0;
        if (albero[index].left != -1) left_length = 1 + altezza(albero, albero[index].left);
        if (albero[index].right != -1) right_length = 1 + altezza(albero, albero[index].right);

        return max(left_length, right_length);
    }
}

int rightmost(node albero[], int index = 0) {
    if (albero[index].left == -1 && albero[index].right == -1) return index;
    else {
        int max_index;
        if (albero[index].left != -1)
            max_index = max(index, rightmost(albero, albero[index].left));
        if (albero[index].right != -1)
            max_index = max(index, rightmost(albero, albero[index].right));
        
        return max_index;
    }
}

const int length = 20;

struct piatto {
    char nome[length];
    char tipo[length];
    int prezzo;
    piatto *next;
};

void print_menu(piatto *menu) {
    piatto *iterator = menu;

    while (iterator != NULL) {
        cout << "Nome: " << iterator -> nome << endl
            << "Tipo: " << iterator -> tipo << endl
            << "Prezzo: " << iterator -> prezzo << endl << endl;
        iterator = iterator -> next;
    }
}

piatto *aggiungi_piatto(piatto *menu, char nome[length], char tipo[length], int prezzo) {
    piatto *tmp = new piatto;
    strcpy(tmp -> nome, nome);
    strcpy(tmp -> tipo, tipo);
    tmp -> prezzo = prezzo;

    if (menu == NULL) {
        menu = tmp;
    } else {
        piatto *iterator = menu;
        while (iterator -> next != NULL) iterator = iterator -> next;

        iterator -> next = tmp; 
    }
    cout << menu -> nome;

    return menu;
}

piatto *give_higher(piatto *menu, int prezzo_min) {
    piatto *nuovo_menu;
    piatto *ultimo_piatto = nuovo_menu;

    piatto *iterator = menu;
    
    while (iterator != NULL) {
        if (iterator -> prezzo >= prezzo_min &&
            strcmp(iterator -> tipo, "antipasto") == 0) {
            ultimo_piatto = new piatto;
            strcpy(ultimo_piatto -> nome, iterator -> nome);
            ultimo_piatto -> prezzo = iterator -> prezzo;
            strcpy(ultimo_piatto -> tipo, iterator -> tipo);
            ultimo_piatto = ultimo_piatto -> next;
        }
        iterator = iterator -> next;
    }

    while (iterator != NULL) {
        if (iterator -> prezzo >= prezzo_min &&
            strcmp(iterator -> tipo, "primo") == 0) {
            ultimo_piatto = new piatto;
            strcpy(ultimo_piatto -> nome, iterator -> nome);
            ultimo_piatto -> prezzo = iterator -> prezzo;
            strcpy(ultimo_piatto -> tipo, iterator -> tipo);
            ultimo_piatto = ultimo_piatto -> next;
        }
        iterator = iterator -> next;
    }

    while (iterator != NULL) {
        if (iterator -> prezzo >= prezzo_min &&
            strcmp(iterator -> tipo, "secondo") == 0) {
            ultimo_piatto = new piatto;
            strcpy(ultimo_piatto -> nome, iterator -> nome);
            ultimo_piatto -> prezzo = iterator -> prezzo;
            strcpy(ultimo_piatto -> tipo, iterator -> tipo);
            ultimo_piatto = ultimo_piatto -> next;
        }
        iterator = iterator -> next;
    }

    while (iterator != NULL) {
        if (iterator -> prezzo >= prezzo_min &&
            strcmp(iterator -> tipo, "dolce") == 0) {
            ultimo_piatto = new piatto;
            strcpy(ultimo_piatto -> nome, iterator -> nome);
            ultimo_piatto -> prezzo = iterator -> prezzo;
            strcpy(ultimo_piatto -> tipo, iterator -> tipo);
            ultimo_piatto = ultimo_piatto -> next;
        }
        iterator = iterator -> next;
    }

    return nuovo_menu;
}

int main() {
    // ricorsione
    node nodo1 = {1, 4, 2};
    node nodo2 = {2, 3, -1};
    node nodo3 = {3, -1, -1};
    node nodo4 = {4, 5, -1};
    node nodo5 = {5, -1, 1};
    node nodo6 = {6, -1, -1};

    node empty_node = {-1, -1, -1};

    node albero[] = {nodo1, nodo4, nodo2, nodo5, nodo3, nodo6, empty_node};

    // cout << altezza(albero) << endl; // deve restituire 4

    // cout << rightmost(albero) << endl; // deve restituire 5

    // liste
    piatto *menu = NULL;

    char nome[length];
    char tipo[length];

    strcpy(nome, "pesce");
    strcpy(tipo, "antipasto");
    menu = aggiungi_piatto(menu, nome, tipo, 7);
    strcpy(nome, "penne");
    strcpy(tipo, "primo");
    menu = aggiungi_piatto(menu, nome, tipo, 10);
    strcpy(nome, "carne");
    strcpy(tipo, "secondo");
    menu = aggiungi_piatto(menu, nome, tipo, 15);
    strcpy(nome, "tagliatelle");
    strcpy(tipo, "primo");
    menu = aggiungi_piatto(menu, nome, tipo, 13);
    strcpy(nome, "torta");
    strcpy(tipo, "dolce");
    menu = aggiungi_piatto(menu, nome, tipo, 6);

    print_menu(menu);

    return 0;
}