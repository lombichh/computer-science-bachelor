#include <iostream>
#include <cstdlib>
#include <ctime>
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

void print_tree(ptree t) {
    if (t != NULL) {
        if (t -> ltree != NULL) print_tree(t -> ltree);
        cout << t -> val << ", ";
        if (t -> rtree != NULL) print_tree(t -> rtree);
    }
}

int get_max(ptree t) {
    if (t -> rtree == NULL) return t -> val;
    else {
        t = t -> rtree;
        get_max(t);
    }
}

int main() {
    srand(time(0));
    ptree t1 = create_tree(4, pow(2, 4) / 2);
    print_tree(t1);
    cout << endl << get_max(t1);

    return 0;
}