#include <iostream>
using namespace std;

struct tree {
    int val;
    tree* ltree;
    tree* rtree;
};
typedef tree* ptree;

ptree t_insert(ptree t, int n) {
    if (t == NULL) {
        t = new tree;
        t -> val = n;
        t -> ltree = NULL;
        t -> rtree = NULL;
    } else if (t -> val == n) return(t);
    else if (t -> val > n) t -> ltree = t_insert(t -> ltree, n);
    else t -> rtree = t_insert(t -> rtree, n);
    return(t);
}

void visit(ptree t) {
    if (t != NULL) {
        cout << t -> val << ", ";
        visit(t -> ltree);
        visit(t -> rtree);
    }
}

int num_leafs(ptree t) {
    if (t == NULL) return 0;
    else if (t -> ltree == NULL && t -> rtree == NULL) return 1;
    else return num_leafs(t -> ltree) + num_leafs(t -> rtree);
}

int main() {
    ptree p1 = NULL;
    p1 = t_insert(p1, 8);
    p1 = t_insert(p1, 7);
    p1 = t_insert(p1, 6);
    p1 = t_insert(p1, 11);

    visit(p1);
    cout << endl;

    cout << num_leafs(p1);

    return 0;
}