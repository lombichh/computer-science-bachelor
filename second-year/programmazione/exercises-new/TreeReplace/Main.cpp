#include <iostream>
#include <math.h>
using namespace std;

struct tree {
    int val;
    tree* ltree;
    tree* rtree;
};
typedef tree* ptree;

ptree create_tree(int n, int num) {
    if (n == 0) return NULL;
    else {
        ptree t = new tree;
        t -> val = num;
        t -> ltree = create_tree(n - 1, num - (pow(2, n - 1) / 2));
        t -> rtree = create_tree(n - 1, num + (pow(2, n - 1) / 2));
        return t;
    }
}

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

void visit(ptree t, int n) {
    if (t != NULL) {
        cout << t -> val << " (" << n << "), ";
        visit(t -> ltree, n + 1);
        visit(t -> rtree, n + 1);
    }
}

ptree replaceTree(ptree t) {
    if (t -> ltree != NULL) t -> ltree = replaceTree(t -> ltree);
    if (t -> rtree != NULL) t -> rtree = replaceTree(t -> rtree);
    if (t -> ltree != NULL && t -> rtree != NULL) {
        t -> val = t -> rtree -> val + t -> ltree -> val;
    }
    return t;
}

int main() {
    ptree p1 = create_tree(3, pow(2, 3) / 2);

    visit(p1, 0);
    cout << endl;

    visit(replaceTree(p1), 0);

    return 0;
}