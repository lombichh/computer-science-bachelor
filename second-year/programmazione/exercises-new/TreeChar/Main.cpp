#include <iostream>
#include <ctime>
#include <cstdlib>
using namespace std;

struct tree {
    char val;
    tree* ltree;
    tree* rtree;
};
typedef tree* ptree;

ptree t_insert(ptree t, char n) {
    if (t == NULL) {
        t = new tree;
        t -> val = n;
        t -> ltree = NULL;
        t -> rtree = NULL;
    } else {
        if (rand() % 2 == 0) t -> ltree = t_insert(t -> ltree, n);
        else t -> rtree = t_insert(t -> rtree, n);
    }
    return(t);
}

void visit(ptree t, int n) {
    if (t != NULL) {
        cout << t -> val << "(" << n << ")";
        visit(t -> ltree, n + 1);
        visit(t -> rtree, n + 1);
    }
}

ptree remove_leafs(ptree t) {
    if (t != NULL) {
        if (t -> rtree == NULL && t -> ltree == NULL) {
            delete t;
            t = NULL;
        }
        else if (t -> ltree != NULL) t -> ltree = remove_leafs(t -> ltree);
        else if (t -> rtree != NULL) t -> rtree = remove_leafs(t -> rtree);
    }

    return t;
}

int main() {
    srand(time(0));

    ptree tree = NULL;
    char a[] = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i'};
    for (int i = 0; i < 9; i++) {
        tree = t_insert(tree, a[i]);
    }

    visit(tree, 0);
    cout << endl;

    tree = remove_leafs(tree);

    visit(tree, 0);

    return 0;
}